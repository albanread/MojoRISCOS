"""RISC OS DragASprite SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_drag_asprite.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def stop() -> None:
    """DragASprite_Stop (SWI &42401). See PRM 3-300."""
    _ = external_call["DragASprite_Stop", Int32]()
