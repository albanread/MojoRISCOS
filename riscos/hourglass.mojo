"""RISC OS Hourglass SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_hourglass.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def colours(colour: Int32, colour2: Int32, out_colour: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Hourglass_Colours (SWI &406C6). See PRM 2-755."""
    return external_call["Hourglass_Colours", Int32](colour, colour2, out_colour)

def leds(value: Int32) -> Int32:
    """Hourglass_LEDs (SWI &406C5). See PRM 2-754."""
    return external_call["Hourglass_LEDs", Int32](value)

def off() -> None:
    """Hourglass_Off (SWI &406C1). See PRM 2-748."""
    _ = external_call["Hourglass_Off", Int32]()

def on() -> None:
    """Hourglass_On (SWI &406C0). See PRM 2-746."""
    _ = external_call["Hourglass_On", Int32]()

def percentage(percentage: Int32) -> None:
    """Hourglass_Percentage (SWI &406C4). See PRM 2-752."""
    _ = external_call["Hourglass_Percentage", Int32](percentage)

def smash() -> None:
    """Hourglass_Smash (SWI &406C2). See PRM 2-750."""
    _ = external_call["Hourglass_Smash", Int32]()

def start(delay: Int32) -> None:
    """Hourglass_Start (SWI &406C3). See PRM 2-751."""
    _ = external_call["Hourglass_Start", Int32](delay)
