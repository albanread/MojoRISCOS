"""RISC OS PDriver SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_pdriver.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def abort_job(file: Int32) -> None:
    """PDriver_AbortJob (SWI &80149). See PRM 3-628."""
    _ = external_call["PDriver_AbortJob", Int32](file)

def cancel_job(file: Int32) -> None:
    """PDriver_CancelJob (SWI &8014E). See PRM 3-638."""
    _ = external_call["PDriver_CancelJob", Int32](file)

def cancel_job_with_error(file: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """PDriver_CancelJobWithError (SWI &80152). See PRM 3-642."""
    _ = external_call["PDriver_CancelJobWithError", Int32](file, block)

def check_features(mask: Int32, value: Int32) -> None:
    """PDriver_CheckFeatures (SWI &80142). See PRM 3-617."""
    _ = external_call["PDriver_CheckFeatures", Int32](mask, value)

def current_job() -> Int32:
    """PDriver_CurrentJob (SWI &80146). See PRM 3-624."""
    return external_call["PDriver_CurrentJob", Int32]()

def declare_font(handle: Int32, name: UnsafePointer[UInt8, MutUntrackedOrigin], flags: Int32) -> None:
    """PDriver_DeclareFont (SWI &80155). See PRM 3-648."""
    _ = external_call["PDriver_DeclareFont", Int32](handle, name, flags)

def draw_page(count: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], page: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin], out_identification: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """PDriver_DrawPage (SWI &8014C). See PRM 3-635."""
    return external_call["PDriver_DrawPage", Int32](count, block, page, string, out_identification)

def end_job(file: Int32) -> None:
    """PDriver_EndJob (SWI &80148). See PRM 3-626."""
    _ = external_call["PDriver_EndJob", Int32](file)

def enumerate_drivers(handle: Int32, out_printer: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """PDriver_EnumerateDrivers (SWI &80159). See PRM 3-655."""
    return external_call["PDriver_EnumerateDrivers", Int32](handle, out_printer)

def enumerate_jobs(handle: Int32) -> Int32:
    """PDriver_EnumerateJobs (SWI &80150). See PRM 3-640."""
    return external_call["PDriver_EnumerateJobs", Int32](handle)

def font_swi() -> None:
    """PDriver_FontSWI (SWI &80147). See PRM 3-625."""
    _ = external_call["PDriver_FontSWI", Int32]()

def get_rectangle(block: UnsafePointer[UInt8, MutUntrackedOrigin], out_identification: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """PDriver_GetRectangle (SWI &8014D). See PRM 3-637."""
    return external_call["PDriver_GetRectangle", Int32](block, out_identification)

def info(out_value: UnsafePointer[Int32, MutUntrackedOrigin], out_value2: UnsafePointer[Int32, MutUntrackedOrigin], out_features: UnsafePointer[Int32, MutUntrackedOrigin], out_ptr: UnsafePointer[Int32, MutUntrackedOrigin], out_value3: UnsafePointer[Int32, MutUntrackedOrigin], out_value4: UnsafePointer[Int32, MutUntrackedOrigin], out_printer: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """PDriver_Info (SWI &80140). See PRM 3-611."""
    return external_call["PDriver_Info", Int32](out_value, out_value2, out_features, out_ptr, out_value3, out_value4, out_printer)

def page_size(out_size: UnsafePointer[Int32, MutUntrackedOrigin], out_left: UnsafePointer[Int32, MutUntrackedOrigin], out_bottom: UnsafePointer[Int32, MutUntrackedOrigin], out_right: UnsafePointer[Int32, MutUntrackedOrigin], out_top: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """PDriver_PageSize (SWI &80143). See PRM 3-618."""
    return external_call["PDriver_PageSize", Int32](out_size, out_left, out_bottom, out_right, out_top)

def remove_driver(printer: Int32) -> None:
    """PDriver_RemoveDriver (SWI &80157). See PRM 3-652."""
    _ = external_call["PDriver_RemoveDriver", Int32](printer)

def reset() -> None:
    """PDriver_Reset (SWI &8014A). See PRM 3-630."""
    _ = external_call["PDriver_Reset", Int32]()

def screen_dump(file: Int32) -> None:
    """PDriver_ScreenDump (SWI &8014F). See PRM 3-639."""
    _ = external_call["PDriver_ScreenDump", Int32](file)

def select_driver(printer: Int32) -> Int32:
    """PDriver_SelectDriver (SWI &80158). See PRM 3-653."""
    return external_call["PDriver_SelectDriver", Int32](printer)

def select_illustration(file: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """PDriver_SelectIllustration (SWI &80153). See PRM 3-644."""
    return external_call["PDriver_SelectIllustration", Int32](file, string)

def select_job(file: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """PDriver_SelectJob (SWI &80145). See PRM 3-622."""
    return external_call["PDriver_SelectJob", Int32](file, string)

def set_printer() -> None:
    """PDriver_SetPrinter (SWI &80151). See PRM 3-641."""
    _ = external_call["PDriver_SetPrinter", Int32]()
