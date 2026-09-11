"""RISC OS RamFS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_ram_fs.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def describe_disc() -> None:
    """RamFS_DescribeDisc (SWI &40785). See PRM 2-320."""
    _ = external_call["RamFS_DescribeDisc", Int32]()

def disc_op() -> None:
    """RamFS_DiscOp (SWI &40780). See PRM 2-317."""
    _ = external_call["RamFS_DiscOp", Int32]()

def drives() -> None:
    """RamFS_Drives (SWI &40782). See PRM 2-318."""
    _ = external_call["RamFS_Drives", Int32]()

def free_space() -> None:
    """RamFS_FreeSpace (SWI &40783). See PRM 2-319."""
    _ = external_call["RamFS_FreeSpace", Int32]()
