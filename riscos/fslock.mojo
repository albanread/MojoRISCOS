"""RISC OS FSLock SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_fslock.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def status(out_locked: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """FSLock_Status (SWI &44781). See PRM 5a-252."""
    return external_call["FSLock_Status", Int32](out_locked)

def version(out_ptr: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """FSLock_Version (SWI &44780). See PRM 5a-251."""
    return external_call["FSLock_Version", Int32](out_ptr)
