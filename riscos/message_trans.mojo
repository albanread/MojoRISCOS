"""RISC OS MessageTrans SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_message_trans.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def close_file(message: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """MessageTrans_CloseFile (SWI &41504). See PRM 3-759."""
    _ = external_call["MessageTrans_CloseFile", Int32](message)

def copy_error(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """MessageTrans_CopyError (SWI &41508). See PRM 3-766."""
    _ = external_call["MessageTrans_CopyError", Int32](block)

def file_info(filename: UnsafePointer[UInt8, MutUntrackedOrigin], out_size: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """MessageTrans_FileInfo (SWI &41500). See PRM 3-750."""
    return external_call["MessageTrans_FileInfo", Int32](filename, out_size)

def make_menus(message: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """MessageTrans_MakeMenus (SWI &41503). See PRM 3-756."""
    _ = external_call["MessageTrans_MakeMenus", Int32](message, ptr, buffer, size)

def open_file(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], filename: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """MessageTrans_OpenFile (SWI &41501). See PRM 3-752."""
    _ = external_call["MessageTrans_OpenFile", Int32](ptr, filename, buffer)
