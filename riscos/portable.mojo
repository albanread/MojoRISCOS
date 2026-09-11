"""RISC OS Portable SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_portable.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def control(mask: Int32, mask2: Int32, out_new: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Portable_Control (SWI &42FC1). See PRM 4-210."""
    return external_call["Portable_Control", Int32](mask, mask2, out_new)

def read_bmuvariable(bmu: Int32) -> Int32:
    """Portable_ReadBMUVariable (SWI &42FC2). See PRM 4-212."""
    return external_call["Portable_ReadBMUVariable", Int32](bmu)

def speed(mask: Int32, mask2: Int32, out_new: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Portable_Speed (SWI &42FC0). See PRM 4-208."""
    return external_call["Portable_Speed", Int32](mask, mask2, out_new)

def write_bmuvariable(bmu: Int32, value: Int32) -> None:
    """Portable_WriteBMUVariable (SWI &42FC3). See PRM 4-214."""
    _ = external_call["Portable_WriteBMUVariable", Int32](bmu, value)
