"""RISC OS ScreenBlanker SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_screen_blanker.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def control() -> None:
    """ScreenBlanker_Control (SWI &43100). See PRM 4-112."""
    _ = external_call["ScreenBlanker_Control", Int32]()
