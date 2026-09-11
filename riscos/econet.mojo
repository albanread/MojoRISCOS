"""RISC OS Econet SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_econet.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def abandon_and_read_receive(handle: Int32, out_flags: UnsafePointer[Int32, MutUntrackedOrigin], out_port: UnsafePointer[Int32, MutUntrackedOrigin], out_station: UnsafePointer[Int32, MutUntrackedOrigin], out_net: UnsafePointer[Int32, MutUntrackedOrigin], out_buffer: UnsafePointer[Int32, MutUntrackedOrigin], out_size: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Econet_AbandonAndReadReceive (SWI &40018). See PRM 2-695."""
    return external_call["Econet_AbandonAndReadReceive", Int32](handle, out_flags, out_port, out_station, out_net, out_buffer, out_size)

def abandon_receive(handle: Int32) -> Int32:
    """Econet_AbandonReceive (SWI &40003). See PRM 2-663."""
    return external_call["Econet_AbandonReceive", Int32](handle)

def abandon_transmit(handle: Int32) -> Int32:
    """Econet_AbandonTransmit (SWI &40008). See PRM 2-671."""
    return external_call["Econet_AbandonTransmit", Int32](handle)

def allocate_port() -> Int32:
    """Econet_AllocatePort (SWI &40013). See PRM 2-688."""
    return external_call["Econet_AllocatePort", Int32]()

def claim_port(port: Int32) -> None:
    """Econet_ClaimPort (SWI &40015). See PRM 2-690."""
    _ = external_call["Econet_ClaimPort", Int32](port)

def de_allocate_port(port: Int32) -> None:
    """Econet_DeAllocatePort (SWI &40014). See PRM 2-689."""
    _ = external_call["Econet_DeAllocatePort", Int32](port)

def enumerate_receive(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Econet_EnumerateReceive (SWI &40005). See PRM 2-666."""
    _ = external_call["Econet_EnumerateReceive", Int32](block)

def enumerate_transmit(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Econet_EnumerateTransmit (SWI &4001F). See PRM 5a-274."""
    _ = external_call["Econet_EnumerateTransmit", Int32](block)

def examine_receive(handle: Int32) -> Int32:
    """Econet_ExamineReceive (SWI &40001). See PRM 2-659."""
    return external_call["Econet_ExamineReceive", Int32](handle)

def hardware_addresses(out_address: UnsafePointer[Int32, MutUntrackedOrigin], out_mask: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Econet_HardwareAddresses (SWI &40020). See PRM 5a-276."""
    return external_call["Econet_HardwareAddresses", Int32](out_address, out_mask)

def inet_rx_direct() -> None:
    """Econet_InetRxDirect (SWI &4001D). See PRM 5a-271."""
    _ = external_call["Econet_InetRxDirect", Int32]()

def network_parameters() -> None:
    """Econet_NetworkParameters (SWI &40021). See PRM 5a-278."""
    _ = external_call["Econet_NetworkParameters", Int32]()

def network_state(station: Int32, net: Int32) -> Int32:
    """Econet_NetworkState (SWI &4001A). See PRM 2-698."""
    return external_call["Econet_NetworkState", Int32](station, net)

def packet_size(station: Int32, net: Int32) -> Int32:
    """Econet_PacketSize (SWI &4001B). See PRM 2-700."""
    return external_call["Econet_PacketSize", Int32](station, net)

def poll_transmit(handle: Int32) -> Int32:
    """Econet_PollTransmit (SWI &40007). See PRM 2-669."""
    return external_call["Econet_PollTransmit", Int32](handle)

def print_banner() -> None:
    """Econet_PrintBanner (SWI &40010). See PRM 2-684."""
    _ = external_call["Econet_PrintBanner", Int32]()

def read_local_station_and_net(out_net: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Econet_ReadLocalStationAndNet (SWI &4000A). See PRM 2-674."""
    return external_call["Econet_ReadLocalStationAndNet", Int32](out_net)

def read_protection() -> Int32:
    """Econet_ReadProtection (SWI &4000D). See PRM 2-679."""
    return external_call["Econet_ReadProtection", Int32]()

def read_receive(handle: Int32, out_flags: UnsafePointer[Int32, MutUntrackedOrigin], out_port: UnsafePointer[Int32, MutUntrackedOrigin], out_station: UnsafePointer[Int32, MutUntrackedOrigin], out_net: UnsafePointer[Int32, MutUntrackedOrigin], out_buffer: UnsafePointer[Int32, MutUntrackedOrigin], out_size: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Econet_ReadReceive (SWI &40002). See PRM 2-661."""
    return external_call["Econet_ReadReceive", Int32](handle, out_flags, out_port, out_station, out_net, out_buffer, out_size)

def read_station_number(string: UnsafePointer[UInt8, MutUntrackedOrigin], out_net: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Econet_ReadStationNumber (SWI &4000F). See PRM 2-683."""
    return external_call["Econet_ReadStationNumber", Int32](string, out_net)

def read_transport_name(station: Int32, net: Int32) -> Int32:
    """Econet_ReadTransportName (SWI &4001C). See PRM 2-702."""
    return external_call["Econet_ReadTransportName", Int32](station, net)

def read_transport_type(station: Int32, net: Int32, arg2: Int32) -> Int32:
    """Econet_ReadTransportType (SWI &40011). See PRM 2-685."""
    return external_call["Econet_ReadTransportType", Int32](station, net, arg2)

def release_port(port: Int32) -> None:
    """Econet_ReleasePort (SWI &40012). See PRM 2-687."""
    _ = external_call["Econet_ReleasePort", Int32](port)

def set_protection(mask: Int32, mask2: Int32) -> Int32:
    """Econet_SetProtection (SWI &4000E). See PRM 2-681."""
    return external_call["Econet_SetProtection", Int32](mask, mask2)

def version(station: Int32, net: Int32) -> Int32:
    """Econet_Version (SWI &40019). See PRM 2-697."""
    return external_call["Econet_Version", Int32](station, net)

def wait_for_reception(handle: Int32, delay: Int32, arg2: Int32, out_flags: UnsafePointer[Int32, MutUntrackedOrigin], out_port: UnsafePointer[Int32, MutUntrackedOrigin], out_station: UnsafePointer[Int32, MutUntrackedOrigin], out_net: UnsafePointer[Int32, MutUntrackedOrigin], out_buffer: UnsafePointer[Int32, MutUntrackedOrigin], out_size: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Econet_WaitForReception (SWI &40004). See PRM 2-664."""
    return external_call["Econet_WaitForReception", Int32](handle, delay, arg2, out_flags, out_port, out_station, out_net, out_buffer, out_size)
