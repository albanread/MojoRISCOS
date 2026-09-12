"""The Mandelbrot set in a window, Q16.16 fixed point.

demos/mandelbrot.mojo draws the set in ASCII. This draws it in colour, in
a real desktop window, with the same arithmetic: there is no FPU here and
no soft-float runtime, so a Float64 anywhere would fail at the linker.
Q16.16 is not a workaround for that - it is what you would have written
for a StrongARM in 1996, and it is far quicker than any soft-float
emulation would be.

The picture is computed once, before the task ever calls Wimp_Initialise,
and kept in a byte per cell. That ordering matters: computing inside the
poll loop would hold up Wimp_Poll and freeze every other application on
the desktop for as long as it took, and computing inside a redraw would
do it again on every expose.

Redraw paints from the buffer, run-length encoded along each row, so a
band of identical colour costs one rectangle rather than thirty-two. The
set has long runs, which is why it is worth doing.
"""

from riscos import os
from riscos import wimp
from demos.vdu import putc, puts, put_int


comptime ONE = 65536                    # 1.0 in Q16.16
comptime FOUR = 4 * ONE                 # escape radius, squared
comptime MAX_ITER = 64

comptime COLS = 128
comptime ROWS = 128
comptime CELL = Int32(4)                # OS units down one side of a cell
comptime STATUS = Int32(52)
comptime W = CELL * COLS
comptime H = CELL * ROWS + STATUS

comptime INSIDE_INK = Int32(7)          # black
comptime GREY_INK = Int32(1)
comptime BLACK_INK = Int32(7)


@always_inline
fn qmul(a: Int32, b: Int32) -> Int32:
    """Q16.16 multiply: the product needs 64 bits on the way through.

    On a 32-bit ARM that is a register pair, and LLVM turns it into a
    single SMULL - an instruction even a StrongARM has.
    """
    return Int32((Int64(a) * Int64(b)) >> 16)


fn colour_of(n: Int32) -> Int32:
    """Escape time to a Wimp colour. Inside the set is black.

    Eight colours cycling on the escape count, which is what makes the
    bands visible: a monotonic ramp over only sixteen desktop colours
    would put most of the interesting structure in one shade.
    """
    if n >= MAX_ITER:
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


fn compute(buf: UnsafePointer[UInt8, MutUntrackedOrigin]):
    """One byte of colour per cell, top row first."""
    # 3.0 wide by 3.0 tall over a square window. The ASCII demo uses
    # +/-1.25 because its character cells are twice as tall as they are
    # wide; here the cells are square, and that range would stretch the
    # set vertically by a fifth.
    let x0 = -2.25 * ONE
    let x1 = 0.75 * ONE
    let y0 = -1.5 * ONE
    let y1 = 1.5 * ONE
    let dx = Int32((x1 - x0) // COLS)
    let dy = Int32((y1 - y0) // ROWS)

    # Rows run downwards on the screen and the imaginary axis runs upwards,
    # so this starts at the top of the range and subtracts.
    var cy = Int32(y1)
    for row in range(ROWS):
        var cx = Int32(x0)
        for col in range(COLS):
            var zr: Int32 = 0
            var zi: Int32 = 0
            var n: Int32 = 0
            while n < MAX_ITER:
                let zr2 = qmul(zr, zr)
                let zi2 = qmul(zi, zi)
                if zr2 + zi2 > FOUR:
                    break
                let t = zr2 - zi2 + cx
                zi = qmul(zr, zi) * 2 + cy
                zr = t
                n += 1
            buf[row * COLS + col] = UInt8(colour_of(n))
            cx += dx
        cy -= dy


fn fill_rect(x0: Int32, y0: Int32, x1: Int32, y1: Int32):
    os.plot(4, x0, y0)
    os.plot(101, x1, y1)


fn draw(buf: UnsafePointer[UInt8, MutUntrackedOrigin], ox: Int32, oy: Int32):
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
    puts("Q16.16 fixed point   ")
    put_int(Int64(MAX_ITER))
    puts(" iters")
    putc(4)


fn main():
    # Before Wimp_Initialise on purpose: this takes a moment, and a task
    # that is not yet a task cannot hold up anybody else's redraw.
    let buf = wimp.alloc(Int32(COLS * ROWS))
    compute(buf)

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

    var running = True
    while running:
        let event = wimp.poll(1, block)
        if event == wimp.REDRAW_WINDOW_REQUEST:
            var more = wimp.begin_redraw(block)
            let ox = wimp.origin_x(block)
            let oy = wimp.origin_y(block)
            while more != 0:
                draw(buf, ox, oy)
                more = wimp.next_rectangle(block)
        elif event == wimp.OPEN_WINDOW_REQUEST:
            wimp.open_window_from_poll(block)
        elif event == wimp.CLOSE_WINDOW_REQUEST:
            running = False

    wimp.close_down(task)
