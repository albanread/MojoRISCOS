

# ------------- hand-written natural Wimp layer -------------
# Multi-register SWIs bound through rostrt's wimp shims (rostrt/wimp.c),
# with idiomatic types on top. Event codes per PRM 3.

from std.memory import stack_allocation
from std.ffi import external_call


struct TaskHandle:
    """Task handle returned by Wimp_Initialise."""
    var value: Int32

    fn __init__(out self, value: Int32):
        self.value = value


struct WindowHandle:
    """Window handle returned by Wimp_CreateWindow."""
    var value: Int32

    fn __init__(out self, value: Int32):
        self.value = value


struct PollBlock:
    """256-byte Wimp_Poll return block (stack allocated)."""
    var ptr: UnsafePointer[UInt8, MutUntrackedOrigin]

    @always_inline
    fn __init__(out self):
        self.ptr = stack_allocation[256, DType.uint8, 4]()

    @always_inline
    fn words(mut self) -> UnsafePointer[Int32, MutUntrackedOrigin]:
        """View the block as 32-bit words."""
        return UnsafePointer[Int32, MutUntrackedOrigin](self.ptr)


comptime NULL_EVENT = Int32(0)
comptime REDRAW_WINDOW_REQUEST = Int32(1)
comptime OPEN_WINDOW_REQUEST = Int32(2)
comptime CLOSE_WINDOW_REQUEST = Int32(3)
comptime POINTER_LEAVING_WINDOW = Int32(4)
comptime POINTER_ENTERING_WINDOW = Int32(5)
comptime MOUSE_CLICK = Int32(6)
comptime USER_DRAG_BOX = Int32(7)
comptime KEY_PRESSED = Int32(8)
comptime MENU_SELECTION = Int32(9)
comptime SCROLL_REQUEST = Int32(10)
comptime USER_MODE_CHANGE = Int32(11)
comptime LOSE_CARET = Int32(12)
comptime GAIN_CARET = Int32(13)
comptime POLLWORD_NONZERO = Int32(14)
comptime USER_MESSAGE = Int32(17)
comptime USER_MESSAGE_RECORDED = Int32(18)
comptime USER_MESSAGE_ACKNOWLEDGE = Int32(19)


def initialise(name: StringLiteral) -> TaskHandle:
    """Registers the task with the Wimp (Wimp_Initialise, PRM 3-59)."""
    let version_out = _version_out()
    let task = external_call["Wimp_Initialise", Int32](
        Int32(310), name.ptr(), version_out
    )
    return TaskHandle(task)

def _version_out() -> UnsafePointer[Int32, MutUntrackedOrigin]:
    """Scratch cell for the Wimp version out-value."""
    return stack_allocation[1, DType.int32, 4]()


def poll(mask: Int32, block: PollBlock) -> Int32:
    """Waits for the next Wimp event (Wimp_Poll, PRM 3-129)."""
    return external_call["Wimp_Poll", Int32](mask, block.ptr)


def report_error(message: StringLiteral, flags: Int32 = 0) -> Int32:
    """Shows a standard RISC OS error box (Wimp_ReportError, PRM 3-173).
    Returns 0 (no click), 1 (OK) or 2 (Cancel)."""
    var buf = stack_allocation[256, DType.uint8, 4]()
    buf.bitcast[Int32]()[0] = 0  # error number 0: information box
    let n = message.byte_length()
    for j in range(n):
        buf[j + 1] = message.unsafe_ptr()[j]
    buf[n + 1] = 0
    return external_call["Wimp_ReportError", Int32](buf, flags, "Mojo".ptr())


def close_down(task: TaskHandle) -> None:
    """Deregisters the task (Wimp_CloseDown)."""
    _ = external_call["Wimp_CloseDown", Int32](task.value)


# ------------- full window support -------------

comptime WF_MOVEABLE = Int32(1) << 1
comptime WF_WIMP_REDRAW = Int32(1) << 4
comptime WF_BACK_ICON = Int32(1) << 24
comptime WF_CLOSE_ICON = Int32(1) << 25
comptime WF_TITLE_BAR = Int32(1) << 26
comptime WF_NEW_STYLE = Int32(1) << 31

comptime IF_TEXT_INDIRECTED = Int32(0x27000101)
"""Text + indirected, foreground 7 on background 2.

bit 0 is what makes it a *text* icon and it was missing: 0x270100 put the
intended 0x27 colour byte at bits 16-23, where it reads as ESG 7 with the
selected bit set, and left the colour nibbles at 0. The icon was therefore
indirected, pointing at a perfectly good string, and drew nothing at all."""


def _arena(bytes_: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    return external_call["rostrt_alloc", UnsafePointer[UInt8, MutUntrackedOrigin]](
        bytes_
    )


def _copy_str(src: StringLiteral) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """Copy a literal into Wimp-lifetime memory; returns NUL-terminated."""
    let n = src.byte_length()
    let buf = _arena(Int32(n + 1))
    for j in range(n):
        buf[j] = src.unsafe_ptr()[j]
    buf[n] = 0
    return buf


@always_inline
fn _w(
    buf: UnsafePointer[UInt8, MutUntrackedOrigin], index: Int32
) -> UnsafePointer[Int32, MutUntrackedOrigin]:
    return buf.bitcast[Int32]() + index


def simple_window(title: StringLiteral, message: StringLiteral) -> WindowHandle:
    """Creates a titled window with one text icon, from a PRM-3-87 template."""
    let block = _arena(Int32(88 + 32))  # fixed part + one icon block

    # visible area + scroll + behind (+0..+27): filled on first OpenWindow
    _w(block, 0)[0] = 300; _w(block, 1)[0] = 500
    _w(block, 2)[0] = 900; _w(block, 3)[0] = 800
    _w(block, 5)[0] = 0; _w(block, 6)[0] = -1

    # window flags: new-style icons, title bar, close+back, moveable,
    # Wimp-redrawn work area
    _w(block, 7)[0] = WF_NEW_STYLE | WF_TITLE_BAR | WF_CLOSE_ICON | WF_BACK_ICON | WF_MOVEABLE | WF_WIMP_REDRAW

    # colours: title fg/bg, work fg/bg, sb outer/inner, focus bg, reserved
    _w(block, 8)[0] = Int32(0x02070207)  # bytes: 07 02 07 02
    _w(block, 9)[0] = Int32(0x00020301)  # bytes: 01 03 02 00

    # work area extent (+40..+52): matches visible area
    _w(block, 10)[0] = 0; _w(block, 11)[0] = 0
    _w(block, 12)[0] = 600; _w(block, 13)[0] = 300

    # title bar icon flags (+56): indirected text; data (+72..+80)
    _w(block, 14)[0] = IF_TEXT_INDIRECTED
    _w(block, 15)[0] = 0  # work area button type: none
    _w(block, 16)[0] = 1  # sprite area: Wimp's (+1)
    _w(block, 17)[0] = 0  # min width/height halfwords: use title width

    # Indirected icon data is text pointer, then validation, then length
    # (PRM 3-64). These first two were the other way round, so the Wimp read
    # the title's text pointer as 0 and drew an empty title bar while the
    # string sat in the validation slot.
    let title_buf = _copy_str(title)
    _store_ptr(_w(block, 18), title_buf)  # +72 pointer to the text
    _w(block, 19)[0] = Int32(-1)  # +76 validation: none
    _w(block, 20)[0] = Int32(64)  # +80 buffer size

    _w(block, 21)[0] = 1  # one icon

    # icon block at +88: bbox, flags, indirected text data
    let iblock = block + 88
    _w(iblock, 0)[0] = 40; _w(iblock, 1)[0] = 100
    _w(iblock, 2)[0] = 560; _w(iblock, 3)[0] = 260
    _w(iblock, 4)[0] = IF_TEXT_INDIRECTED
    _store_ptr(_w(iblock, 5), _copy_str(message))
    _w(iblock, 6)[0] = Int32(-1)  # validation: none, not a null pointer
    _w(iblock, 7)[0] = Int32(64)

    return WindowHandle(create_window(block))


def _store_ptr(
    slot: UnsafePointer[Int32, MutUntrackedOrigin],
    p: UnsafePointer[UInt8, MutUntrackedOrigin],
) -> None:
    """Store a pointer into a 32-bit template word (ARM32: one word)."""
    slot[0] = Int32(p.__int__())


def open_block_for(win: WindowHandle) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """Builds a Wimp_OpenWindow block for a window (arena-lifetime)."""
    let b = _arena(Int32(24))
    _w(b, 0)[0] = win.value
    _w(b, 1)[0] = 300; _w(b, 2)[0] = 500
    _w(b, 3)[0] = 900; _w(b, 4)[0] = 800
    _w(b, 5)[0] = -1  # top of the stack
    return b


def open_window_from_poll(block: PollBlock) -> None:
    """Re-opens a window from an Open_Window_Request poll block
    (block words 0..5 already match the open block format)."""
    _ = external_call["Wimp_OpenWindow", Int32](block.ptr)
