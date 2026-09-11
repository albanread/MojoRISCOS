"""RISC OS Debugger SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_debugger.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def disassemble() -> None:
    """Debugger_Disassemble (SWI &40380). See PRM 4-226."""
    _ = external_call["Debugger_Disassemble", Int32]()
