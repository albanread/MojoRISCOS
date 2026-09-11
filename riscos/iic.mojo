"""RISC OS IIC SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_iic.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def control(address: UnsafePointer[UInt8, MutUntrackedOrigin], block: UnsafePointer[UInt8, MutUntrackedOrigin], block2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """IIC_Control (SWI &240). See PRM 1-979."""
    _ = external_call["IIC_Control", Int32](address, block, block2)
