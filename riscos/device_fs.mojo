"""RISC OS DeviceFS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_device_fs.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def deregister(handle: Int32) -> None:
    """DeviceFS_Deregister (SWI &42741). See PRM 2-438."""
    _ = external_call["DeviceFS_Deregister", Int32](handle)

def deregister_objects(handle: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """DeviceFS_DeregisterObjects (SWI &42743). See PRM 2-440."""
    _ = external_call["DeviceFS_DeregisterObjects", Int32](handle, ptr)

def received_character(byte: Int32, handle: Int32) -> None:
    """DeviceFS_ReceivedCharacter (SWI &42746). See PRM 2-443."""
    _ = external_call["DeviceFS_ReceivedCharacter", Int32](byte, handle)

def register_objects(handle: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """DeviceFS_RegisterObjects (SWI &42742). See PRM 2-439."""
    _ = external_call["DeviceFS_RegisterObjects", Int32](handle, ptr)

def threshold(handle: Int32, value: Int32) -> None:
    """DeviceFS_Threshold (SWI &42745). See PRM 2-442."""
    _ = external_call["DeviceFS_Threshold", Int32](handle, value)
