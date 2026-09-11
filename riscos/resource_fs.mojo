"""RISC OS ResourceFS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_resource_fs.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def deregister_files() -> None:
    """ResourceFS_DeregisterFiles (SWI &41B41). See PRM 2-424."""
    _ = external_call["ResourceFS_DeregisterFiles", Int32]()

def register_files(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """ResourceFS_RegisterFiles (SWI &41B40). See PRM 2-422."""
    _ = external_call["ResourceFS_RegisterFiles", Int32](ptr)
