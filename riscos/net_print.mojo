"""RISC OS NetPrint SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_net_print.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def bind_psname(buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """NetPrint_BindPSName (SWI &40206). See PRM 2-404."""
    return external_call["NetPrint_BindPSName", Int32](buffer)

def convert_status_to_string() -> None:
    """NetPrint_ConvertStatusToString (SWI &40208). See PRM 2-408."""
    _ = external_call["NetPrint_ConvertStatusToString", Int32]()

def list_servers(format: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin], time: Int32, out_buffer: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetPrint_ListServers (SWI &40207). See PRM 2-405."""
    return external_call["NetPrint_ListServers", Int32](format, buffer, length, time, out_buffer)

def read_psname(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """NetPrint_ReadPSName (SWI &40202). See PRM 2-399."""
    return external_call["NetPrint_ReadPSName", Int32](buffer, size)

def read_psnumber(out_net: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetPrint_ReadPSNumber (SWI &40200). See PRM 2-397."""
    return external_call["NetPrint_ReadPSNumber", Int32](out_net)

def read_pstimeouts(out_transmit: UnsafePointer[Int32, MutUntrackedOrigin], out_machine: UnsafePointer[Int32, MutUntrackedOrigin], out_machine2: UnsafePointer[Int32, MutUntrackedOrigin], out_receive: UnsafePointer[Int32, MutUntrackedOrigin], out_broadcast: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """NetPrint_ReadPSTimeouts (SWI &40204). See PRM 2-402."""
    return external_call["NetPrint_ReadPSTimeouts", Int32](out_transmit, out_machine, out_machine2, out_receive, out_broadcast)

def set_psname(buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """NetPrint_SetPSName (SWI &40203). See PRM 2-401."""
    _ = external_call["NetPrint_SetPSName", Int32](buffer)

def set_psnumber(station: Int32, net: Int32) -> None:
    """NetPrint_SetPSNumber (SWI &40201). See PRM 2-398."""
    _ = external_call["NetPrint_SetPSNumber", Int32](station, net)
