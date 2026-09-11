"""RISC OS Podule SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_podule.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def call_loader(user: Int32, expansion: Int32) -> Int32:
    """Podule_CallLoader (SWI &40286). See PRM 4-149."""
    return external_call["Podule_CallLoader", Int32](user, expansion)

def enumerate_chunks(chunk: Int32, section: Int32, out_size: UnsafePointer[Int32, MutUntrackedOrigin], out_operating: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Podule_EnumerateChunks (SWI &40282). See PRM 4-142."""
    return external_call["Podule_EnumerateChunks", Int32](chunk, section, out_size, out_operating)

def enumerate_chunks_with_info(chunk: Int32, section: Int32, out_size: UnsafePointer[Int32, MutUntrackedOrigin], out_operating: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Podule_EnumerateChunksWithInfo (SWI &4028A). See PRM 4-157."""
    return external_call["Podule_EnumerateChunksWithInfo", Int32](chunk, section, out_size, out_operating)

def hardware_address(section: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Podule_HardwareAddress (SWI &40289). See PRM 4-155."""
    _ = external_call["Podule_HardwareAddress", Int32](section)

def hardware_addresses(section: Int32, out_address: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Podule_HardwareAddresses (SWI &4028B). See PRM 4-159."""
    return external_call["Podule_HardwareAddresses", Int32](section, out_address)

def raw_read(offset: UnsafePointer[UInt8, MutUntrackedOrigin], count: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], section: Int32) -> None:
    """Podule_RawRead (SWI &40287). See PRM 4-151."""
    _ = external_call["Podule_RawRead", Int32](offset, count, buffer, section)

def raw_write(offset: UnsafePointer[UInt8, MutUntrackedOrigin], count: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], expansion: Int32) -> None:
    """Podule_RawWrite (SWI &40288). See PRM 4-153."""
    _ = external_call["Podule_RawWrite", Int32](offset, count, buffer, expansion)

def read_bytes(offset: Int32, count: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], expansion: Int32) -> None:
    """Podule_ReadBytes (SWI &40284). See PRM 4-145."""
    _ = external_call["Podule_ReadBytes", Int32](offset, count, buffer, expansion)

def read_chunk(chunk: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], section: Int32) -> None:
    """Podule_ReadChunk (SWI &40283). See PRM 4-144."""
    _ = external_call["Podule_ReadChunk", Int32](chunk, buffer, section)

def read_header(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], section: Int32) -> None:
    """Podule_ReadHeader (SWI &40281). See PRM 4-140."""
    _ = external_call["Podule_ReadHeader", Int32](buffer, section)

def read_id(section: Int32) -> Int32:
    """Podule_ReadID (SWI &40280). See PRM 4-139."""
    return external_call["Podule_ReadID", Int32](section)

def read_info(mask: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin], section: Int32) -> None:
    """Podule_ReadInfo (SWI &4028D). See PRM 5a-631."""
    _ = external_call["Podule_ReadInfo", Int32](mask, buffer, length, section)

def return_number(out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Podule_ReturnNumber (SWI &4028C). See PRM 4-161."""
    return external_call["Podule_ReturnNumber", Int32](out_count)

def write_bytes(offset: Int32, count: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], expansion: Int32) -> None:
    """Podule_WriteBytes (SWI &40285). See PRM 4-147."""
    _ = external_call["Podule_WriteBytes", Int32](offset, count, buffer, expansion)
