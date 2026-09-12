"""Othello as a real desktop application: a window you click on.

demos/othello.mojo plays itself and prints the result. This is the same
game with a person on one side of it - a Wimp task with its own window,
drawing its own board, taking moves from the mouse and answering them.

The rules come straight from the console demo rather than being written
out again, so there is one implementation of "which discs does this move
turn over" and both programs are playing the same game.

Black is you, White is the positional engine from the demo - it scores
corners highly and the squares beside them negatively, which is enough to
punish greed. Click a square to play it; illegal squares do nothing.

No SWI appears here. The board is drawn with os.plot and the window comes
from wimp.game_window, both of which are the library's problem.
"""

from std.memory import stack_allocation
from riscos import os
from riscos import wimp
from demos.vdu import putc, puts, put_int
from demos.othello import EMPTY, BLACK, WHITE, flips, play, best_move, count


comptime SQ = Int32(64)                 # OS units down one side of a square
comptime BOARD = SQ * 8
comptime STATUS = Int32(52)             # strip along the top for the score
comptime W = BOARD
comptime H = BOARD + STATUS

# Wimp palette entries, by name rather than by number at the call site.
comptime WHITE_INK = Int32(0)
comptime GREY_INK = Int32(1)
comptime BLACK_INK = Int32(7)
comptime FELT_INK = Int32(13)           # dark green


fn fill_rect(x0: Int32, y0: Int32, x1: Int32, y1: Int32):
    """Filled rectangle in the current colour (PLOT 4 move, PLOT 101 fill)."""
    os.plot(4, x0, y0)
    os.plot(101, x1, y1)


fn fill_circle(cx: Int32, cy: Int32, r: Int32):
    """Filled circle: move to the centre, plot to a point on the rim."""
    os.plot(4, cx, cy)
    os.plot(157, cx + r, cy)


fn draw(b: UnsafePointer[UInt8, MutUntrackedOrigin],
        ox: Int32, oy: Int32, turn: Int32, over: Bool):
    """Paint the whole work area, in screen coordinates.

    A user-redrawn window is handed no background, so every pixel here is
    ours to fill - including the strip behind the score, which is why the
    grey rectangle comes first rather than being left to the Wimp.
    """
    let top = oy
    let felt_top = oy - STATUS

    wimp.set_colour(GREY_INK)
    fill_rect(ox, felt_top, ox + W, top)

    wimp.set_colour(FELT_INK)
    fill_rect(ox, felt_top - BOARD, ox + W, felt_top)

    wimp.set_colour(BLACK_INK)
    for i in range(9):
        let x = ox + Int32(i) * SQ
        fill_rect(x - 1, felt_top - BOARD, x + 1, felt_top)
        let y = felt_top - Int32(i) * SQ
        fill_rect(ox, y - 1, ox + BOARD, y + 1)

    for row in range(8):
        for col in range(8):
            let v = Int32(b[Int(row * 8 + col)])
            if v == EMPTY:
                continue
            if v == BLACK:
                wimp.set_colour(BLACK_INK)
            else:
                wimp.set_colour(WHITE_INK)
            fill_circle(ox + Int32(col) * SQ + SQ // 2,
                        felt_top - Int32(row) * SQ - SQ // 2,
                        SQ // 2 - 7)

    # VDU 5 puts characters at the graphics cursor, so the score can sit in
    # the strip without a text-window mode change. Long String values come
    # back corrupted on this target (see demos/vdu.mojo), hence write_c.
    wimp.set_colour(BLACK_INK)
    # The system font is 16 OS units wide, so 512 units is 32 characters and
    # the strip has to be written to fit: the first version ran off the right
    # edge at "your mov".
    os.plot(4, ox + 8, top - 34)
    putc(5)
    puts("Black ")
    put_int(Int64(count(b, BLACK)))
    puts("  White ")
    put_int(Int64(count(b, WHITE)))
    if over:
        puts("  game over")
    elif turn == BLACK:
        puts("  your move")
    else:
        puts("  thinking")
    putc(4)


fn advance(b: UnsafePointer[UInt8, MutUntrackedOrigin],
           mut turn: Int32, mut passes: Int32):
    """Play on until it is the human's move again, or nobody can move.

    Othello passes rather than ending when one side is stuck, so this is a
    loop and not a single engine reply: White may answer several times over
    while Black has nothing legal to play.
    """
    while passes < 2:
        if turn == BLACK:
            if best_move(b, BLACK, False) < 0:
                passes += 1
                turn = WHITE
                continue
            return                      # your move; wait for the mouse
        let sq = best_move(b, WHITE, True)
        if sq < 0:
            passes += 1
            turn = BLACK
            continue
        passes = 0
        play(b, sq, WHITE)
        turn = BLACK


fn repaint(win: wimp.WindowHandle, block: wimp.PollBlock,
           b: UnsafePointer[UInt8, MutUntrackedOrigin],
           turn: Int32, over: Bool):
    """Draw now, rather than asking the Wimp to ask us later."""
    var more = wimp.begin_update(win, block, 0, -H, W, 0)
    while more != 0:
        draw(b, wimp.origin_x(block), wimp.origin_y(block), turn, over)
        more = wimp.next_rectangle(block)


fn main():
    var b = stack_allocation[64, DType.uint8, 4]()
    for i in range(64):
        b[i] = EMPTY
    b[27] = WHITE
    b[28] = BLACK
    b[35] = BLACK
    b[36] = WHITE

    let task = wimp.initialise("Othello")
    let win = wimp.game_window("Othello", W, H)

    var block = wimp.PollBlock()
    let open = block.words()
    open[0] = win.value
    open[1] = 300
    open[2] = 300
    open[3] = 300 + W
    open[4] = 300 + H
    open[5] = 0
    open[6] = 0
    open[7] = -1
    wimp.open_window_from_poll(block)

    var turn: Int32 = BLACK
    var passes: Int32 = 0
    var ox: Int32 = 300
    var oy: Int32 = 300 + H
    var running = True

    while running:
        let event = wimp.poll(1, block)     # mask 1: no null events wanted

        if event == wimp.REDRAW_WINDOW_REQUEST:
            ox = 0
            var more = wimp.begin_redraw(block)
            ox = wimp.origin_x(block)
            oy = wimp.origin_y(block)
            while more != 0:
                draw(b, ox, oy, turn, passes >= 2)
                more = wimp.next_rectangle(block)

        elif event == wimp.OPEN_WINDOW_REQUEST:
            wimp.open_window_from_poll(block)
            ox = wimp.origin_x(block)
            oy = wimp.origin_y(block)

        elif event == wimp.CLOSE_WINDOW_REQUEST:
            running = False

        elif event == wimp.MOUSE_CLICK:
            # The click block carries the pointer, not the window's position,
            # so the origin is the one cached from the last redraw or open.
            # Every window move raises Open_Window_Request, so it is current.
            let dx = wimp.word(block, 0) - ox
            let dy = oy - wimp.word(block, 1) - STATUS
            if dx >= 0 and dx < BOARD and dy >= 0 and dy < BOARD:
                let sq = (dy // SQ) * 8 + (dx // SQ)
                if turn == BLACK and passes < 2 and flips(b, sq, BLACK) > 0:
                    play(b, sq, BLACK)
                    passes = 0
                    turn = WHITE
                    advance(b, turn, passes)
                    repaint(win, block, b, turn, passes >= 2)

    wimp.close_down(task)
