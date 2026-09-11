"""RISC OS FilerAction SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_filer_action.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def send_selected_directory(task: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """FilerAction_SendSelectedDirectory (SWI &40F80). See PRM 2-514."""
    _ = external_call["FilerAction_SendSelectedDirectory", Int32](task, ptr)

def send_selected_file(task: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """FilerAction_SendSelectedFile (SWI &40F81). See PRM 2-515."""
    _ = external_call["FilerAction_SendSelectedFile", Int32](task, ptr)

def send_start_operation() -> None:
    """FilerAction_SendStartOperation (SWI &40F82). See PRM 2-518."""
    _ = external_call["FilerAction_SendStartOperation", Int32]()
