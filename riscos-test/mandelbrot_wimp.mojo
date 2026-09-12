"""The Mandelbrot set in a window, Q16.16 fixed point, click to zoom.

demos/mandelbrot.mojo draws the set in ASCII. This draws it in colour, in
a real desktop window, with the same arithmetic: there is no FPU here and
no soft-float runtime, so a Float64 anywhere would fail at the linker.
Q16.16 is not a workaround for that - it is what you would have written
for a StrongARM in 1996, and it is far quicker than any soft-float
emulation would be.

Select zooms in on the point clicked, Adjust zooms back out. That is the
RISC OS convention for a pair of opposite actions, and it saves inventing
a menu for two verbs.

Q16.16 sets the floor on how deep the zoom can go, and it is not deep.
The fraction is sixteen bits, so the finest step representable is 1/65536.
Starting from a span of 3.0 across 128 cells the step is 1536 units and
every zoom halves it, so by the ninth it is 3 and the picture is visibly
quantised. Zooming in therefore stops when the next step would fall below
2, rather than dissolving into blocks. Going deeper is not a matter of
more iterations; it needs a wider fixed point.

Redraw paints from a byte-per-cell buffer, run-length encoded along each
row, so a band of identical colour costs one rectangle rather than
thirty-two. The set has long runs, which is why it is worth doing.
"""

from riscos import os
from riscos import wimp
from demos.vdu import putc, puts, put_int


comptime ONE = 65536                    # 1.0 in Q16.16
comptime FOUR = 4 * ONE                 # escape radius, squared

comptime COLS = 128
comptime ROWS = 128
comptime CELL = Int32(4)                # OS units down one side of a cell
comptime STATUS = Int32(52)
comptime W = CELL * COLS
comptime H = CELL * ROWS + STATUS

comptime BASE_ITER = Int32(64)
comptime ITER_PER_ZOOM = Int32(32)
comptime ITER_CAP = Int32(256)
comptime MIN_STEP = Int32(2)            # below this, Q16.16 has run out

comptime INSIDE_INK = Int32(7)          # black
comptime GREY_INK = Int32(1)
comptime BLACK_INK = Int32(7)

comptime SELECT = Int32(4)
comptime ADJUST = Int32(1)


@always_inline
fn qmul(a: Int32, b: Int32) -> Int32:
    """Q16.16 multiply: the product needs 64 bits on the way through.

    On a 32-bit ARM that is a register pair, and LLVM turns it into a
    single SMULL - an instruction even a StrongARM has.
    """
    return Int32((Int64(a) * Int64(b)) >> 16)


fn iterations_at(depth: Int32) -> Int32:
    """A deeper view needs more iterations or it all reads as inside."""
    let n = BASE_ITER + depth * ITER_PER_ZOOM
    if n > ITER_CAP:
        return ITER_CAP
    return n


fn colour_of(n: Int32, max_iter: Int32) -> Int32:
    """Escape time to a Wimp colour. Inside the set is black.

    Eight colours cycling on the escape count, which is what makes the
    bands visible: a monotonic ramp over only sixteen desktop colours
    would put most of the interesting structure in one shade.
    """
    if n >= max_iter:
        return INSIDE_INK
    let k = n % 8
    if k == 0:
        return 8                        # dark blue
    if k == 1:
        return 15                       # light blue
    if k == 2:
        return 10                       # green
    if k == 3:
        return 13                       # dark green
    if k == 4:
        return 9                        # yellow
    if k == 5:
        return 14                       # orange
    if k == 6:
        return 11                       # red
    return 12                           # cream


fn step_for(half: Int32) -> Int32:
    """The Q16.16 distance from one cell to the next."""
    return (2 * half) // COLS


fn compute(buf: UnsafePointer[UInt8, MutUntrackedOrigin],
           centre_x: Int32, centre_y: Int32, half: Int32, max_iter: Int32):
    """One byte of colour per cell, top row first.

    The view is a centre and a half-span rather than a pair of corners,
    because that is what zooming acts on: recentre, then halve.
    """
    let step = step_for(half)
    let left = centre_x - half
    let upper = centre_y + half

    # Rows run downwards on the screen and the imaginary axis runs upwards,
    # so this starts at the top of the range and subtracts.
    var cy = upper
    for row in range(ROWS):
        var cx = left
        for col in range(COLS):
            var zr: Int32 = 0
            var zi: Int32 = 0
            var n: Int32 = 0
            while n < max_iter:
                let zr2 = qmul(zr, zr)
                let zi2 = qmul(zi, zi)
                if zr2 + zi2 > FOUR:
                    break
                let t = zr2 - zi2 + cx
                zi = qmul(zr, zi) * 2 + cy
                zr = t
                n += 1
            buf[row * COLS + col] = UInt8(colour_of(n, max_iter))
            cx += step
        cy -= step


fn fill_rect(x0: Int32, y0: Int32, x1: Int32, y1: Int32):
    os.plot(4, x0, y0)
    os.plot(101, x1, y1)


fn draw(buf: UnsafePointer[UInt8, MutUntrackedOrigin],
        ox: Int32, oy: Int32, depth: Int32, max_iter: Int32):
    let top = oy
    let plot_top = oy - STATUS

    wimp.set_colour(GREY_INK)
    fill_rect(ox, plot_top, ox + W, top)

    for row in range(ROWS):
        let y1 = plot_top - Int32(row) * CELL
        let y0 = y1 - CELL
        var col = 0
        while col < COLS:
            let c = Int32(buf[row * COLS + col])
            var run = 1
            while col + run < COLS and Int32(buf[row * COLS + col + run]) == c:
                run += 1
            wimp.set_colour(c)
            fill_rect(ox + Int32(col) * CELL, y0,
                      ox + Int32(col + run) * CELL - 1, y1 - 1)
            col += run

    wimp.set_colour(BLACK_INK)
    os.plot(4, ox + 8, top - 12)
    # 512 OS units is 32 characters of the system font, and the title bar
    # already says what this is, so the strip does not repeat it.
    putc(5)
    puts("Q16.16  zoom ")
    put_int(Int64(Int32(1) << depth))
    puts("  ")
    put_int(Int64(max_iter))
    puts(" it")
    putc(4)


fn repaint(win: wimp.WindowHandle, block: wimp.PollBlock,
           buf: UnsafePointer[UInt8, MutUntrackedOrigin],
           depth: Int32, max_iter: Int32):
    """Draw now, rather than asking the Wimp to ask us later."""
    var more = wimp.begin_update(win, block, 0, -H, W, 0)
    while more != 0:
        draw(buf, wimp.origin_x(block), wimp.origin_y(block), depth, max_iter)
        more = wimp.next_rectangle(block)


fn main():
    # Before Wimp_Initialise on purpose: this takes a moment, and a task
    # that is not yet a task cannot hold up anybody else's redraw.
    let buf = wimp.alloc(Int32(COLS * ROWS))

    # -0.75 and 1.5 as exact Q16.16, written as integer arithmetic rather
    # than Int32(-0.75 * ONE): a float literal will not convert, and in a
    # fixed-point program the integer form is the honest one anyway.
    var centre_x = Int32(-3 * ONE // 4)
    var centre_y = Int32(0)
    var half = Int32(3 * ONE // 2)
    var depth = Int32(0)
    var max_iter = iterations_at(0)
    compute(buf, centre_x, centre_y, half, max_iter)

    let task = wimp.initialise("Mandelbrot")
    let win = wimp.game_window("Mandelbrot", W, H)

    var block = wimp.PollBlock()
    let open = block.words()
    open[0] = win.value
    open[1] = 260
    open[2] = 260
    open[3] = 260 + W
    open[4] = 260 + H
    open[5] = 0
    open[6] = 0
    open[7] = -1
    wimp.open_window_from_poll(block)

    # A Mouse_Click block carries the pointer and not the window, so the
    # origin has to be the one cached from the last redraw or open. Every
    # window move raises Open_Window_Request, so it stays current.
    var ox = Int32(260)
    var oy = Int32(260 + H)
    var running = True

    while running:
        let event = wimp.poll(1, block)

        if event == wimp.REDRAW_WINDOW_REQUEST:
            var more = wimp.begin_redraw(block)
            ox = wimp.origin_x(block)
            oy = wimp.origin_y(block)
            while more != 0:
                draw(buf, ox, oy, depth, max_iter)
                more = wimp.next_rectangle(block)

        elif event == wimp.OPEN_WINDOW_REQUEST:
            wimp.open_window_from_poll(block)
            ox = wimp.origin_x(block)
            oy = wimp.origin_y(block)

        elif event == wimp.CLOSE_WINDOW_REQUEST:
            running = False

        elif event == wimp.MOUSE_CLICK:
            let buttons = wimp.word(block, 2)
            let dx = wimp.word(block, 0) - ox
            let dy = (oy - STATUS) - wimp.word(block, 1)
            var changed = False

            if dx >= 0 and dx < W and dy >= 0 and dy < CELL * ROWS:
                if buttons == SELECT:
                    # Recentre on the clicked cell, then halve the span.
                    # Refused rather than allowed to dissolve when the next
                    # step would fall below what Q16.16 can represent.
                    let next_half = half // 2
                    if step_for(next_half) >= MIN_STEP:
                        let step = step_for(half)
                        centre_x = centre_x - half + (dx // CELL) * step
                        centre_y = centre_y + half - (dy // CELL) * step
                        half = next_half
                        depth += 1
                        changed = True
                elif buttons == ADJUST:
                    if depth > 0:
                        half = half * 2
                        depth -= 1
                        changed = True

            if changed:
                # This does block the desktop: Wimp_Poll is not called again
                # until it returns. The hourglass is the RISC OS way of
                # admitting that. Slicing the work across Null events is the
                # real answer if it ever grows past a second or so.
                # An hourglass belongs here and cannot have one yet:
                # hourglass.on() exists as a binding and as a C shim, but
                # only swis_os and swis_wimp of the library's 45 modules
                # are ever compiled and linked, so it fails with
                # "undefined: Hourglass_On". The fix is the library
                # becoming an archive the linker draws from, not another
                # object hardcoded into the link line.
                max_iter = iterations_at(depth)
                compute(buf, centre_x, centre_y, half, max_iter)
                repaint(win, block, buf, depth, max_iter)

    wimp.close_down(task)
