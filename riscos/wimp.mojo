"""RISC OS Wimp SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_wimp.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def add_messages(message: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_AddMessages (SWI &400F6). See PRM 3-224."""
    _ = external_call["Wimp_AddMessages", Int32](message)

def base_of_sprites(out_sprite_area: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Wimp_BaseOfSprites (SWI &400EA). See PRM 3-200."""
    return external_call["Wimp_BaseOfSprites", Int32](out_sprite_area)

def claim_free_memory(arg0: Int32, amount: Int32, out_address: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Wimp_ClaimFreeMemory (SWI &400EE). See PRM 3-208."""
    return external_call["Wimp_ClaimFreeMemory", Int32](arg0, amount, out_address)

def close_template() -> None:
    """Wimp_CloseTemplate (SWI &400DA). See PRM 3-166."""
    _ = external_call["Wimp_CloseTemplate", Int32]()

def close_window(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_CloseWindow (SWI &400C6). See PRM 3-111."""
    _ = external_call["Wimp_CloseWindow", Int32](block)

def command_window(operation: Int32) -> None:
    """Wimp_CommandWindow (SWI &400EF). See PRM 3-210."""
    _ = external_call["Wimp_CommandWindow", Int32](operation)

def create_icon(icon: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_CreateIcon (SWI &400C2). See PRM 3-93."""
    return external_call["Wimp_CreateIcon", Int32](icon, block)

def create_menu(block: UnsafePointer[UInt8, MutUntrackedOrigin], x: Int32, y: Int32) -> None:
    """Wimp_CreateMenu (SWI &400D4). See PRM 3-153."""
    _ = external_call["Wimp_CreateMenu", Int32](block, x, y)

def create_sub_menu(block: UnsafePointer[UInt8, MutUntrackedOrigin], x: Int32, y: Int32) -> None:
    """Wimp_CreateSubMenu (SWI &400E8). See PRM 3-196."""
    _ = external_call["Wimp_CreateSubMenu", Int32](block, x, y)

def create_window(window_block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_CreateWindow (SWI &400C1). See PRM 3-87."""
    return external_call["Wimp_CreateWindow", Int32](window_block)

def decode_menu(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], ptr2: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_DecodeMenu (SWI &400D5). See PRM 3-158."""
    _ = external_call["Wimp_DecodeMenu", Int32](ptr, ptr2, buffer)

def delete_icon(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_DeleteIcon (SWI &400C4). See PRM 3-107."""
    _ = external_call["Wimp_DeleteIcon", Int32](block)

def delete_window(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_DeleteWindow (SWI &400C3). See PRM 3-105."""
    _ = external_call["Wimp_DeleteWindow", Int32](block)

def drag_box(arg1: Int32) -> None:
    """Wimp_DragBox (SWI &400D0). See PRM 3-142."""
    _ = external_call["Wimp_DragBox", Int32](arg1)

def extend() -> None:
    """Wimp_Extend (SWI &400FB). See PRM 5a-507."""
    _ = external_call["Wimp_Extend", Int32]()

def get_caret_position(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_GetCaretPosition (SWI &400D3). See PRM 3-151."""
    _ = external_call["Wimp_GetCaretPosition", Int32](block)

def get_icon_state(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_GetIconState (SWI &400CE). See PRM 3-138."""
    _ = external_call["Wimp_GetIconState", Int32](block)

def get_menu_state(arg0: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], window: Int32, icon: Int32) -> None:
    """Wimp_GetMenuState (SWI &400F4). See PRM 3-220."""
    _ = external_call["Wimp_GetMenuState", Int32](arg0, buffer, window, icon)

def get_pointer_info(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_GetPointerInfo (SWI &400CF). See PRM 3-140."""
    _ = external_call["Wimp_GetPointerInfo", Int32](block)

def get_rectangle(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_GetRectangle (SWI &400CA). See PRM 3-130."""
    return external_call["Wimp_GetRectangle", Int32](block)

def get_window_info(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_GetWindowInfo (SWI &400CC). See PRM 3-134."""
    _ = external_call["Wimp_GetWindowInfo", Int32](block)

def get_window_outline(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_GetWindowOutline (SWI &400E0). See PRM 3-179."""
    _ = external_call["Wimp_GetWindowOutline", Int32](block)

def get_window_state() -> None:
    """Wimp_GetWindowState (SWI &400CB). See PRM 3-132."""
    _ = external_call["Wimp_GetWindowState", Int32]()

def open_template(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_OpenTemplate (SWI &400D9). See PRM 3-165."""
    _ = external_call["Wimp_OpenTemplate", Int32](ptr)

def open_window(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_OpenWindow (SWI &400C5). See PRM 3-109."""
    _ = external_call["Wimp_OpenWindow", Int32](block)

def plot_icon(icon_block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_PlotIcon (SWI &400E2). See PRM 3-183."""
    _ = external_call["Wimp_PlotIcon", Int32](icon_block)

def poll(mask: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_Poll (SWI &400C7). See PRM 3-112."""
    return external_call["Wimp_Poll", Int32](mask, block, ptr)

def process_key(character: Int32) -> None:
    """Wimp_ProcessKey (SWI &400DC). See PRM 3-170."""
    _ = external_call["Wimp_ProcessKey", Int32](character)

def read_palette(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_ReadPalette (SWI &400E5). See PRM 3-189."""
    _ = external_call["Wimp_ReadPalette", Int32](block)

def read_pix_trans() -> None:
    """Wimp_ReadPixTrans (SWI &400ED). See PRM 3-206."""
    _ = external_call["Wimp_ReadPixTrans", Int32]()

def read_sys_info(information: Int32) -> Int32:
    """Wimp_ReadSysInfo (SWI &400F2). See PRM 3-216."""
    return external_call["Wimp_ReadSysInfo", Int32](information)

def redraw_window(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_RedrawWindow (SWI &400C8). See PRM 3-126."""
    return external_call["Wimp_RedrawWindow", Int32](block)

def register_filter() -> None:
    """Wimp_RegisterFilter (SWI &400F5). See PRM 3-222."""
    _ = external_call["Wimp_RegisterFilter", Int32]()

def remove_messages(message: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_RemoveMessages (SWI &400F7). See PRM 3-225."""
    _ = external_call["Wimp_RemoveMessages", Int32](message)

def report_error(block: UnsafePointer[UInt8, MutUntrackedOrigin], flags: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_ReportError (SWI &400DF). See PRM 3-176."""
    return external_call["Wimp_ReportError", Int32](block, flags, ptr)

def resize_icon() -> None:
    """Wimp_ResizeIcon (SWI &400FC). See PRM 5a-510."""
    _ = external_call["Wimp_ResizeIcon", Int32]()

def send_message(event: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], task: Int32, icon: Int32) -> Int32:
    """Wimp_SendMessage (SWI &400E7). See PRM 3-193."""
    return external_call["Wimp_SendMessage", Int32](event, block, task, icon)

def set_colour(colour: Int32) -> None:
    """Wimp_SetColour (SWI &400E6). See PRM 3-191."""
    _ = external_call["Wimp_SetColour", Int32](colour)

def set_extent(window: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_SetExtent (SWI &400D7). See PRM 3-161."""
    _ = external_call["Wimp_SetExtent", Int32](window, block)

def set_font_colours(colour: Int32, colour2: Int32) -> None:
    """Wimp_SetFontColours (SWI &400F3). See PRM 3-218."""
    _ = external_call["Wimp_SetFontColours", Int32](colour, colour2)

def set_icon_state(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_SetIconState (SWI &400CD). See PRM 3-136."""
    _ = external_call["Wimp_SetIconState", Int32](block)

def set_mode(mode: Int32) -> None:
    """Wimp_SetMode (SWI &400E3). See PRM 3-185."""
    _ = external_call["Wimp_SetMode", Int32](mode)

def set_palette(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_SetPalette (SWI &400E4). See PRM 3-187."""
    _ = external_call["Wimp_SetPalette", Int32](block)

def set_watchdog_state(state: Int32, code: Int32) -> None:
    """Wimp_SetWatchdogState (SWI &400FA). See PRM 5a-506."""
    _ = external_call["Wimp_SetWatchdogState", Int32](state, code)

def slot_size(size: Int32, size2: Int32, out_size: UnsafePointer[Int32, MutUntrackedOrigin], out_size2: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Wimp_SlotSize (SWI &400EC). See PRM 3-203."""
    return external_call["Wimp_SlotSize", Int32](size, size2, out_size, out_size2)

def start_task(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Wimp_StartTask (SWI &400DE). See PRM 3-174."""
    _ = external_call["Wimp_StartTask", Int32](ptr)

def text_colour(colour: Int32) -> None:
    """Wimp_TextColour (SWI &400F0). See PRM 3-212."""
    _ = external_call["Wimp_TextColour", Int32](colour)

def update_window(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Wimp_UpdateWindow (SWI &400C9). See PRM 3-128."""
    return external_call["Wimp_UpdateWindow", Int32](block)

def which_icon(window: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], mask: Int32, arg3: Int32) -> None:
    """Wimp_WhichIcon (SWI &400D6). See PRM 3-159."""
    _ = external_call["Wimp_WhichIcon", Int32](window, block, mask, arg3)



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
