"""RISC OS DragAnObject SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_drag_an_object.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def stop() -> None:
    """DragAnObject_Stop (SWI &49C41). See PRM 5a-519."""
    _ = external_call["DragAnObject_Stop", Int32]()
