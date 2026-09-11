"""RISC OS BASICTrans SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_basictrans.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def error(unique: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """BASICTrans_Error (SWI &42C81). See PRM 4-243."""
    _ = external_call["BASICTrans_Error", Int32](unique, buffer)

def help(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], ptr2: UnsafePointer[UInt8, MutUntrackedOrigin], ptr3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """BASICTrans_HELP (SWI &42C80). See PRM 4-242."""
    _ = external_call["BASICTrans_HELP", Int32](ptr, ptr2, ptr3)

def message(message: Int32, message2: Int32) -> None:
    """BASICTrans_Message (SWI &42C82). See PRM 4-244."""
    _ = external_call["BASICTrans_Message", Int32](message, message2)
