"""RISC OS Filter SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_filter.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def de_register_pre_filter(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], ptr2: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32, task: Int32) -> None:
    """Filter_DeRegisterPreFilter (SWI &42642). See PRM 3-308."""
    _ = external_call["Filter_DeRegisterPreFilter", Int32](ptr, ptr2, value, task)
