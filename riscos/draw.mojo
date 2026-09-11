"""RISC OS Draw SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_draw.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def ile_declare_fonts() -> None:
    """DrawFile_DeclareFonts (SWI &45542). See PRM 5a-530."""
    _ = external_call["DrawFile_DeclareFonts", Int32]()

def fill(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], fill: Int32, ptr2: UnsafePointer[UInt8, MutUntrackedOrigin], flatness: Int32) -> None:
    """Draw_Fill (SWI &40702). See PRM 3-548."""
    _ = external_call["Draw_Fill", Int32](ptr, fill, ptr2, flatness)

def flatten_path(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], flatness: Int32) -> None:
    """Draw_FlattenPath (SWI &40708). See PRM 3-554."""
    _ = external_call["Draw_FlattenPath", Int32](ptr, size, flatness)

def process_path() -> None:
    """Draw_ProcessPath (SWI &40700). See PRM 3-546."""
    _ = external_call["Draw_ProcessPath", Int32]()

def transform_path(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], ptr2: UnsafePointer[UInt8, MutUntrackedOrigin], ptr3: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: Int32) -> None:
    """Draw_TransformPath (SWI &4070A). See PRM 3-556."""
    _ = external_call["Draw_TransformPath", Int32](ptr, ptr2, ptr3, arg3)
