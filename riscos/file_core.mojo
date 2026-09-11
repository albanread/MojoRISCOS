"""RISC OS FileCore SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_file_core.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def disc_format(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], swi: Int32, parameter: Int32, format: Int32) -> None:
    """FileCore_DiscFormat (SWI &40547). See PRM 2-236."""
    _ = external_call["FileCore_DiscFormat", Int32](ptr, swi, parameter, format)

def disc_op() -> None:
    """FileCore_DiscOp (SWI &40540). See PRM 2-224."""
    _ = external_call["FileCore_DiscOp", Int32]()

def floppy_structure(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, ptr2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """FileCore_FloppyStructure (SWI &40544). See PRM 2-232."""
    _ = external_call["FileCore_FloppyStructure", Int32](buffer, ptr, arg2, ptr2)

def layout_structure(identifier: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin], file: Int32) -> None:
    """FileCore_LayoutStructure (SWI &40548). See PRM 2-239."""
    _ = external_call["FileCore_LayoutStructure", Int32](identifier, block, ptr, file)
