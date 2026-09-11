"""RISC OS CompressJPEG SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_compress_jpeg.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def finish(jpeg: Int32) -> Int32:
    """CompressJPEG_Finish (SWI &4A502). See PRM 5a-622."""
    return external_call["CompressJPEG_Finish", Int32](jpeg)

def write_line(jpeg: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """CompressJPEG_WriteLine (SWI &4A501). See PRM 5a-621."""
    _ = external_call["CompressJPEG_WriteLine", Int32](jpeg, buffer)
