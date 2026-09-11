"""RISC OS NetFS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_net_fs.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def convert_date(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """NetFS_ConvertDate (SWI &4004B). See PRM 2-364."""
    _ = external_call["NetFS_ConvertDate", Int32](ptr, buffer)

def do_fsop(file: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], count: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """NetFS_DoFSOp (SWI &40048). See PRM 2-358."""
    return external_call["NetFS_DoFSOp", Int32](file, buffer, count, size)

def enable_cache() -> None:
    """NetFS_EnableCache (SWI &40051). See PRM 2-376."""
    _ = external_call["NetFS_EnableCache", Int32]()

def enumerate_fs(offset: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], count: Int32, out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetFS_EnumerateFS (SWI &4004A). See PRM 2-362."""
    return external_call["NetFS_EnumerateFS", Int32](offset, buffer, size, count, out_count)

def enumerate_fscontexts(entry: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], count: UnsafePointer[UInt8, MutUntrackedOrigin], count2: Int32, out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetFS_EnumerateFSContexts (SWI &4004E). See PRM 2-370."""
    return external_call["NetFS_EnumerateFSContexts", Int32](entry, buffer, count, count2, out_count)

def enumerate_fslist(offset: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], count: Int32, out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetFS_EnumerateFSList (SWI &40049). See PRM 2-360."""
    return external_call["NetFS_EnumerateFSList", Int32](offset, buffer, size, count, out_count)

def read_current_context() -> None:
    """NetFS_ReadCurrentContext (SWI &40044). See PRM 2-354."""
    _ = external_call["NetFS_ReadCurrentContext", Int32]()

def read_fsname(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """NetFS_ReadFSName (SWI &40042). See PRM 2-352."""
    return external_call["NetFS_ReadFSName", Int32](buffer, size)

def read_fsnumber(out_net: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetFS_ReadFSNumber (SWI &40040). See PRM 2-350."""
    return external_call["NetFS_ReadFSNumber", Int32](out_net)

def read_fstimeouts(out_transmit: UnsafePointer[Int32, MutUntrackedOrigin], out_machine: UnsafePointer[Int32, MutUntrackedOrigin], out_machine2: UnsafePointer[Int32, MutUntrackedOrigin], out_receive: UnsafePointer[Int32, MutUntrackedOrigin], out_broadcast: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetFS_ReadFSTimeouts (SWI &40046). See PRM 2-356."""
    return external_call["NetFS_ReadFSTimeouts", Int32](out_transmit, out_machine, out_machine2, out_receive, out_broadcast)

def read_user_id(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], count: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """NetFS_ReadUserId (SWI &4004F). See PRM 2-372."""
    _ = external_call["NetFS_ReadUserId", Int32](buffer, count)

def set_current_context() -> None:
    """NetFS_SetCurrentContext (SWI &40045). See PRM 2-355."""
    _ = external_call["NetFS_SetCurrentContext", Int32]()

def set_fsname(buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """NetFS_SetFSName (SWI &40043). See PRM 2-353."""
    _ = external_call["NetFS_SetFSName", Int32](buffer)

def set_fsnumber(station: Int32, net: Int32) -> None:
    """NetFS_SetFSNumber (SWI &40041). See PRM 2-351."""
    _ = external_call["NetFS_SetFSNumber", Int32](station, net)

def update_fslist(station: Int32, net: Int32) -> None:
    """NetFS_UpdateFSList (SWI &4004D). See PRM 2-368."""
    _ = external_call["NetFS_UpdateFSList", Int32](station, net)
