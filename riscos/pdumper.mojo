"""RISC OS PDumper SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_pdumper.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def copy_filename(string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], string2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """PDumper_CopyFilename (SWI &41B09). See PRM 3-706."""
    _ = external_call["PDumper_CopyFilename", Int32](string, size, string2)

def find(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """PDumper_Find (SWI &41B03). See PRM 3-695."""
    _ = external_call["PDumper_Find", Int32](ptr, block)

def free(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """PDumper_Free (SWI &41B02). See PRM 3-694."""
    _ = external_call["PDumper_Free", Int32](ptr, block)

def info(out_colour: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """PDumper_Info (SWI &41B00). See PRM 3-690."""
    return external_call["PDumper_Info", Int32](out_colour)

def lookup_error(block: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """PDumper_LookupError (SWI &41B08). See PRM 3-704."""
    _ = external_call["PDumper_LookupError", Int32](block, string)

def start_job(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], flags: Int32, filename: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """PDumper_StartJob (SWI &41B04). See PRM 3-696."""
    _ = external_call["PDumper_StartJob", Int32](ptr, flags, filename)
