"""RISC OS DOSFS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_dosfs.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def disc_format(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], swi: Int32, parameter: Int32, format: Int32) -> None:
    """DOSFS_DiscFormat (SWI &44B00). See PRM 2-335."""
    _ = external_call["DOSFS_DiscFormat", Int32](ptr, swi, parameter, format)

def layout_structure(structure: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin], file: Int32) -> None:
    """DOSFS_LayoutStructure (SWI &44B01). See PRM 2-338."""
    _ = external_call["DOSFS_LayoutStructure", Int32](structure, block, ptr, file)
