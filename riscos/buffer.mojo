"""RISC OS Buffer SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_buffer.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def create(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Buffer_Create (SWI &42940). See PRM 4-88."""
    _ = external_call["Buffer_Create", Int32](buffer, size, handle)

def deregister(handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Buffer_Deregister (SWI &42943). See PRM 4-93."""
    _ = external_call["Buffer_Deregister", Int32](handle)

def get_info(handle: UnsafePointer[UInt8, MutUntrackedOrigin], out_buffer: UnsafePointer[Int32, MutUntrackedOrigin], out_offset: UnsafePointer[Int32, MutUntrackedOrigin], out_offset2: UnsafePointer[Int32, MutUntrackedOrigin], out_buffer2: UnsafePointer[Int32, MutUntrackedOrigin], out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Buffer_GetInfo (SWI &42947). See PRM 4-99."""
    return external_call["Buffer_GetInfo", Int32](handle, out_buffer, out_offset, out_offset2, out_buffer2, out_count)

def modify_flags(handle: UnsafePointer[UInt8, MutUntrackedOrigin], mask: Int32, mask2: Int32, out_value: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Buffer_ModifyFlags (SWI &42944). See PRM 4-94."""
    return external_call["Buffer_ModifyFlags", Int32](handle, mask, mask2, out_value)

def register(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], buffer2: UnsafePointer[UInt8, MutUntrackedOrigin], buffer3: UnsafePointer[UInt8, MutUntrackedOrigin], handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Buffer_Register (SWI &42942). See PRM 4-91."""
    _ = external_call["Buffer_Register", Int32](buffer, buffer2, buffer3, handle)

def remove(handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Buffer_Remove (SWI &42941). See PRM 4-90."""
    _ = external_call["Buffer_Remove", Int32](handle)

def threshold(handle: UnsafePointer[UInt8, MutUntrackedOrigin], threshold: Int32) -> Int32:
    """Buffer_Threshold (SWI &42948). See PRM 4-101."""
    return external_call["Buffer_Threshold", Int32](handle, threshold)

def unlink_device(handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Buffer_UnlinkDevice (SWI &42946). See PRM 4-98."""
    _ = external_call["Buffer_UnlinkDevice", Int32](handle)
