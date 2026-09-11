"""RISC OS ADFS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_adfs.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def controller_type(drive: Int32) -> None:
    """ADFS_ControllerType (SWI &40248). See PRM 2-294."""
    _ = external_call["ADFS_ControllerType", Int32](drive)

def describe_disc() -> None:
    """ADFS_DescribeDisc (SWI &40245). See PRM 2-290."""
    _ = external_call["ADFS_DescribeDisc", Int32]()

def disc_op() -> None:
    """ADFS_DiscOp (SWI &40240). See PRM 2-283."""
    _ = external_call["ADFS_DiscOp", Int32]()

def drives() -> None:
    """ADFS_Drives (SWI &40242). See PRM 2-286."""
    _ = external_call["ADFS_Drives", Int32]()

def eccsand_retries() -> None:
    """ADFS_ECCSAndRetries (SWI &40250). See PRM 2-303."""
    _ = external_call["ADFS_ECCSAndRetries", Int32]()

def flp_process_dcb() -> None:
    """ADFS_FlpProcessDCB (SWI &40247). See PRM 2-293."""
    _ = external_call["ADFS_FlpProcessDCB", Int32]()

def free_space() -> None:
    """ADFS_FreeSpace (SWI &40243). See PRM 2-287."""
    _ = external_call["ADFS_FreeSpace", Int32]()

def free_space64() -> None:
    """ADFS_FreeSpace64 (SWI &40252). See PRM 5a-189."""
    _ = external_call["ADFS_FreeSpace64", Int32]()

def lock_ide(flags: Int32) -> None:
    """ADFS_LockIDE (SWI &40251). See PRM 5a-188."""
    _ = external_call["ADFS_LockIDE", Int32](flags)

def misc_op() -> None:
    """ADFS_MiscOp (SWI &4024C). See PRM 2-302."""
    _ = external_call["ADFS_MiscOp", Int32]()

def retries(mask: Int32, value: Int32, out_value: UnsafePointer[Int32, MutUntrackedOrigin], out_value2: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ADFS_Retries (SWI &40244). See PRM 2-288."""
    return external_call["ADFS_Retries", Int32](mask, value, out_value, out_value2)

def sector_disc_op() -> None:
    """ADFS_SectorDiscOp (SWI &4024D). See PRM 5a-187."""
    _ = external_call["ADFS_SectorDiscOp", Int32]()

def vet_format(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], parameter: Int32) -> None:
    """ADFS_VetFormat (SWI &40246). See PRM 2-291."""
    _ = external_call["ADFS_VetFormat", Int32](ptr, parameter)
