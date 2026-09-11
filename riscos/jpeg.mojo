"""RISC OS JPEG SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_jpeg.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def file_info(flags: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], out_width: UnsafePointer[Int32, MutUntrackedOrigin], out_height: UnsafePointer[Int32, MutUntrackedOrigin], out_value: UnsafePointer[Int32, MutUntrackedOrigin], out_value2: UnsafePointer[Int32, MutUntrackedOrigin], out_sprite: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """JPEG_FileInfo (SWI &49981). See PRM 5a-151."""
    return external_call["JPEG_FileInfo", Int32](flags, ptr, out_width, out_height, out_value, out_value2, out_sprite)

def info(flags: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: Int32, out_width: UnsafePointer[Int32, MutUntrackedOrigin], out_height: UnsafePointer[Int32, MutUntrackedOrigin], out_value: UnsafePointer[Int32, MutUntrackedOrigin], out_value2: UnsafePointer[Int32, MutUntrackedOrigin], out_sprite: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """JPEG_Info (SWI &49980). See PRM 5a-149."""
    return external_call["JPEG_Info", Int32](flags, buffer, length, out_width, out_height, out_value, out_value2, out_sprite)

def pdriver_intercept(flags: Int32) -> Int32:
    """JPEG_PDriverIntercept (SWI &49986). See PRM 5a-161."""
    return external_call["JPEG_PDriverIntercept", Int32](flags)

def plot_file_transformed(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], block: UnsafePointer[UInt8, MutUntrackedOrigin], block2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """JPEG_PlotFileTransformed (SWI &49985). See PRM 5a-159."""
    _ = external_call["JPEG_PlotFileTransformed", Int32](ptr, block, block2)

def plot_transformed(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], block: UnsafePointer[UInt8, MutUntrackedOrigin], block2: UnsafePointer[UInt8, MutUntrackedOrigin], length: Int32) -> None:
    """JPEG_PlotTransformed (SWI &49984). See PRM 5a-157."""
    _ = external_call["JPEG_PlotTransformed", Int32](buffer, block, block2, length)
