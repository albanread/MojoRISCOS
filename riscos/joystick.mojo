"""RISC OS Joystick SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_joystick.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def calibrate_top_right() -> None:
    """Joystick_CalibrateTopRight (SWI &43F41). See PRM 5a-651."""
    _ = external_call["Joystick_CalibrateTopRight", Int32]()
