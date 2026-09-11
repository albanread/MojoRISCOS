"""RISC OS TaskManager SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_task_manager.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def enumerate_tasks(value: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """TaskManager_EnumerateTasks (SWI &42681). See PRM 3-313."""
    return external_call["TaskManager_EnumerateTasks", Int32](value, buffer, length)

def shutdown(flags: Int32) -> None:
    """TaskManager_Shutdown (SWI &42682). See PRM 3-315."""
    _ = external_call["TaskManager_Shutdown", Int32](flags)

def task_name_from_handle(task: Int32) -> Int32:
    """TaskManager_TaskNameFromHandle (SWI &42680). See PRM 3-312."""
    return external_call["TaskManager_TaskNameFromHandle", Int32](task)
