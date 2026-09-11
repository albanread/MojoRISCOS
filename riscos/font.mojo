"""RISC OS Font SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_font.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def apply_fields(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], ptr2: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], size2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Font_ApplyFields (SWI &400A7). See PRM 3-504."""
    _ = external_call["Font_ApplyFields", Int32](ptr, ptr2, size, size2)

def cache_addr(out_size: UnsafePointer[Int32, MutUntrackedOrigin], out_amount: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_CacheAddr (SWI &40080). See PRM 3-426."""
    return external_call["Font_CacheAddr", Int32](out_size, out_amount)

def char_bbox(font: Int32, ascii: Int32, flags: Int32, out_bbox: UnsafePointer[Int32, MutUntrackedOrigin], out_bbox2: UnsafePointer[Int32, MutUntrackedOrigin], out_bbox3: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_CharBBox (SWI &4008E). See PRM 3-454."""
    return external_call["Font_CharBBox", Int32](font, ascii, flags, out_bbox, out_bbox2, out_bbox3)

def convertto_os(x: Int32, y: Int32, out_y: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_ConverttoOS (SWI &40088). See PRM 3-446."""
    return external_call["Font_ConverttoOS", Int32](x, y, out_y)

def converttopoints(x: Int32, y: Int32, out_y: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_Converttopoints (SWI &40089). See PRM 3-447."""
    return external_call["Font_Converttopoints", Int32](x, y, out_y)

def current_font(out_colour: UnsafePointer[Int32, MutUntrackedOrigin], out_colour2: UnsafePointer[Int32, MutUntrackedOrigin], out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_CurrentFont (SWI &4008B). See PRM 3-449."""
    return external_call["Font_CurrentFont", Int32](out_colour, out_colour2, out_offset)

def current_rgb(out_colour: UnsafePointer[Int32, MutUntrackedOrigin], out_colour2: UnsafePointer[Int32, MutUntrackedOrigin], out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_CurrentRGB (SWI &400A3). See PRM 3-497."""
    return external_call["Font_CurrentRGB", Int32](out_colour, out_colour2, out_offset)

def find_caret(string: UnsafePointer[UInt8, MutUntrackedOrigin], offset: Int32, offset2: Int32, out_offset: UnsafePointer[Int32, MutUntrackedOrigin], out_count: UnsafePointer[Int32, MutUntrackedOrigin], out_string: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_FindCaret (SWI &4008D). See PRM 3-452."""
    return external_call["Font_FindCaret", Int32](string, offset, offset2, out_offset, out_count, out_string)

def find_field(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], character: Int32) -> None:
    """Font_FindField (SWI &400A6). See PRM 3-503."""
    _ = external_call["Font_FindField", Int32](ptr, character)

def future_font(out_colour: UnsafePointer[Int32, MutUntrackedOrigin], out_colour2: UnsafePointer[Int32, MutUntrackedOrigin], out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_FutureFont (SWI &4008C). See PRM 3-451."""
    return external_call["Font_FutureFont", Int32](out_colour, out_colour2, out_offset)

def future_rgb(out_colour: UnsafePointer[Int32, MutUntrackedOrigin], out_colour2: UnsafePointer[Int32, MutUntrackedOrigin], out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_FutureRGB (SWI &400A4). See PRM 3-499."""
    return external_call["Font_FutureRGB", Int32](out_colour, out_colour2, out_offset)

def lookup_font(font: Int32, arg1: Int32, arg2: Int32) -> Int32:
    """Font_LookupFont (SWI &400A8). See PRM 3-506."""
    return external_call["Font_LookupFont", Int32](font, arg1, arg2)

def lose_font(font: Int32) -> None:
    """Font_LoseFont (SWI &40082). See PRM 3-431."""
    _ = external_call["Font_LoseFont", Int32](font)

def paint() -> None:
    """Font_Paint (SWI &40086). See PRM 3-438."""
    _ = external_call["Font_Paint", Int32]()

def read_colour_table(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Font_ReadColourTable (SWI &40098). See PRM 3-473."""
    _ = external_call["Font_ReadColourTable", Int32](ptr)

def read_defn(font: Int32, size: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: Int32, out_size: UnsafePointer[Int32, MutUntrackedOrigin], out_value: UnsafePointer[Int32, MutUntrackedOrigin], out_value2: UnsafePointer[Int32, MutUntrackedOrigin], out_age: UnsafePointer[Int32, MutUntrackedOrigin], out_usage: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_ReadDefn (SWI &40083). See PRM 3-432."""
    return external_call["Font_ReadDefn", Int32](font, size, arg3, out_size, out_value, out_value2, out_age, out_usage)

def read_encoding_filename(font: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Font_ReadEncodingFilename (SWI &400A5). See PRM 3-501."""
    return external_call["Font_ReadEncodingFilename", Int32](font, buffer, length)

def read_font_max(out_value: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_ReadFontMax (SWI &4009C). See PRM 3-480."""
    return external_call["Font_ReadFontMax", Int32](out_value)

def read_font_prefix(font: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Font_ReadFontPrefix (SWI &4009D). See PRM 3-481."""
    _ = external_call["Font_ReadFontPrefix", Int32](font, buffer, length)

def read_info(font: Int32, out_y: UnsafePointer[Int32, MutUntrackedOrigin], out_x: UnsafePointer[Int32, MutUntrackedOrigin], out_y2: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_ReadInfo (SWI &40084). See PRM 3-434."""
    return external_call["Font_ReadInfo", Int32](font, out_y, out_x, out_y2)

def read_scale_factor(out_value: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_ReadScaleFactor (SWI &4008F). See PRM 3-456."""
    return external_call["Font_ReadScaleFactor", Int32](out_value)

def read_thresholds(buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Font_ReadThresholds (SWI &40094). See PRM 3-465."""
    _ = external_call["Font_ReadThresholds", Int32](buffer)

def set_colour_table() -> None:
    """Font_SetColourTable (SWI &400A2). See PRM 3-495."""
    _ = external_call["Font_SetColourTable", Int32]()

def set_font(handle: Int32) -> None:
    """Font_SetFont (SWI &4008A). See PRM 3-448."""
    _ = external_call["Font_SetFont", Int32](handle)

def set_font_colours(font: Int32, colour: Int32, colour2: Int32, offset: Int32) -> None:
    """Font_SetFontColours (SWI &40092). See PRM 3-461."""
    _ = external_call["Font_SetFontColours", Int32](font, colour, colour2, offset)

def set_scale_factor(arg1: Int32, arg2: Int32) -> None:
    """Font_SetScaleFactor (SWI &40090). See PRM 3-457."""
    _ = external_call["Font_SetScaleFactor", Int32](arg1, arg2)

def set_thresholds(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Font_SetThresholds (SWI &40095). See PRM 3-468."""
    _ = external_call["Font_SetThresholds", Int32](ptr)

def string_bbox(string: UnsafePointer[UInt8, MutUntrackedOrigin], out_bbox: UnsafePointer[Int32, MutUntrackedOrigin], out_bbox2: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Font_StringBBox (SWI &40097). See PRM 3-471."""
    return external_call["Font_StringBBox", Int32](string, out_bbox, out_bbox2)

def switch_output_to_buffer(flags: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Font_SwitchOutputToBuffer (SWI &4009E). See PRM 3-483."""
    return external_call["Font_SwitchOutputToBuffer", Int32](flags, buffer)

def un_cache_file(filename: UnsafePointer[UInt8, MutUntrackedOrigin], flags: Int32) -> None:
    """Font_UnCacheFile (SWI &4009A). See PRM 3-476."""
    _ = external_call["Font_UnCacheFile", Int32](filename, flags)
