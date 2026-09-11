"""RISC OS ColourTrans SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_colour_trans.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def colour_number_to_gcol(colour: Int32) -> Int32:
    """ColourTrans_ColourNumberToGCOL (SWI &4074D). See PRM 3-367."""
    return external_call["ColourTrans_ColourNumberToGCOL", Int32](colour)

def convert_cieto_rgb(value: Int32, value2: Int32, value3: Int32, out_green: UnsafePointer[Int32, MutUntrackedOrigin], out_blue: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertCIEToRGB (SWI &40756). See PRM 3-381."""
    return external_call["ColourTrans_ConvertCIEToRGB", Int32](value, value2, value3, out_green, out_blue)

def convert_cmykto_rgb(cyan: Int32, magenta: Int32, yellow: Int32, key: Int32, out_green: UnsafePointer[Int32, MutUntrackedOrigin], out_blue: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertCMYKToRGB (SWI &4075B). See PRM 3-391."""
    return external_call["ColourTrans_ConvertCMYKToRGB", Int32](cyan, magenta, yellow, key, out_green, out_blue)

def convert_device_colour(colour: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertDeviceColour (SWI &40753). See PRM 3-376."""
    return external_call["ColourTrans_ConvertDeviceColour", Int32](colour, ptr)

def convert_device_palette(count: Int32, colour: UnsafePointer[UInt8, MutUntrackedOrigin], colour2: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """ColourTrans_ConvertDevicePalette (SWI &40754). See PRM 3-377."""
    _ = external_call["ColourTrans_ConvertDevicePalette", Int32](count, colour, colour2, ptr)

def convert_hsvto_rgb(hue: Int32, saturation: Int32, value: Int32, out_green: UnsafePointer[Int32, MutUntrackedOrigin], out_blue: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertHSVToRGB (SWI &40759). See PRM 3-387."""
    return external_call["ColourTrans_ConvertHSVToRGB", Int32](hue, saturation, value, out_green, out_blue)

def convert_rgbto_cie(red: Int32, green: Int32, blue: Int32, out_value: UnsafePointer[Int32, MutUntrackedOrigin], out_value2: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertRGBToCIE (SWI &40755). See PRM 3-379."""
    return external_call["ColourTrans_ConvertRGBToCIE", Int32](red, green, blue, out_value, out_value2)

def convert_rgbto_cmyk(red: Int32, green: Int32, blue: Int32, out_magenta: UnsafePointer[Int32, MutUntrackedOrigin], out_yellow: UnsafePointer[Int32, MutUntrackedOrigin], out_key: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertRGBToCMYK (SWI &4075A). See PRM 3-389."""
    return external_call["ColourTrans_ConvertRGBToCMYK", Int32](red, green, blue, out_magenta, out_yellow, out_key)

def convert_rgbto_hsv(red: Int32, green: Int32, blue: Int32, out_saturation: UnsafePointer[Int32, MutUntrackedOrigin], out_value: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ConvertRGBToHSV (SWI &40758). See PRM 3-385."""
    return external_call["ColourTrans_ConvertRGBToHSV", Int32](red, green, blue, out_saturation, out_value)

def gcolto_colour_number(gcol: Int32) -> Int32:
    """ColourTrans_GCOLToColourNumber (SWI &4074C). See PRM 3-366."""
    return external_call["ColourTrans_GCOLToColourNumber", Int32](gcol)

def generate_table() -> None:
    """ColourTrans_GenerateTable (SWI &40763). See PRM 3-406."""
    _ = external_call["ColourTrans_GenerateTable", Int32]()

def invalidate_cache() -> None:
    """ColourTrans_InvalidateCache (SWI &40750). See PRM 3-372."""
    _ = external_call["ColourTrans_InvalidateCache", Int32]()

def misc_op() -> None:
    """ColourTrans_MiscOp (SWI &4075F). See PRM 3-399."""
    _ = external_call["ColourTrans_MiscOp", Int32]()

def read_calibration(size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ReadCalibration (SWI &40752). See PRM 3-375."""
    return external_call["ColourTrans_ReadCalibration", Int32](size)

def return_colour_number(palette_entry: Int32) -> Int32:
    """ColourTrans_ReturnColourNumber (SWI &40744). See PRM 3-352."""
    return external_call["ColourTrans_ReturnColourNumber", Int32](palette_entry)

def return_colour_number_for_mode(palette_entry: Int32, mode: Int32, palette: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ReturnColourNumberForMode (SWI &40746). See PRM 3-355."""
    return external_call["ColourTrans_ReturnColourNumberForMode", Int32](palette_entry, mode, palette)

def return_font_colours(font: Int32, palette_entry: Int32, palette_entry2: Int32, offset: Int32, out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ReturnFontColours (SWI &4074E). See PRM 3-368."""
    return external_call["ColourTrans_ReturnFontColours", Int32](font, palette_entry, palette_entry2, offset, out_offset)

def return_gcol(palette_entry: Int32) -> Int32:
    """ColourTrans_ReturnGCOL (SWI &40742). See PRM 3-348."""
    return external_call["ColourTrans_ReturnGCOL", Int32](palette_entry)

def return_gcolfor_mode(palette_entry: Int32, mode: Int32, palette: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ReturnGCOLForMode (SWI &40745). See PRM 3-353."""
    return external_call["ColourTrans_ReturnGCOLForMode", Int32](palette_entry, mode, palette)

def return_opp_colour_number(palette_entry: Int32) -> Int32:
    """ColourTrans_ReturnOppColourNumber (SWI &40749). See PRM 3-361."""
    return external_call["ColourTrans_ReturnOppColourNumber", Int32](palette_entry)

def return_opp_colour_number_for_mode(palette_entry: Int32, mode: Int32, palette: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ReturnOppColourNumberForMode (SWI &4074B). See PRM 3-364."""
    return external_call["ColourTrans_ReturnOppColourNumberForMode", Int32](palette_entry, mode, palette)

def return_opp_gcol(palette_entry: Int32) -> Int32:
    """ColourTrans_ReturnOppGCOL (SWI &40747). See PRM 3-357."""
    return external_call["ColourTrans_ReturnOppGCOL", Int32](palette_entry)

def return_opp_gcolfor_mode(palette_entry: Int32, mode: Int32, palette: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_ReturnOppGCOLForMode (SWI &4074A). See PRM 3-362."""
    return external_call["ColourTrans_ReturnOppGCOLForMode", Int32](palette_entry, mode, palette)

def set_calibration(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """ColourTrans_SetCalibration (SWI &40751). See PRM 3-374."""
    _ = external_call["ColourTrans_SetCalibration", Int32](ptr)

def set_font_colours(font: Int32, palette_entry: Int32, palette_entry2: Int32, offset: Int32, out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """ColourTrans_SetFontColours (SWI &4074F). See PRM 3-370."""
    return external_call["ColourTrans_SetFontColours", Int32](font, palette_entry, palette_entry2, offset, out_offset)

def set_opp_text_colour(palette_entry: Int32, colour: Int32) -> Int32:
    """ColourTrans_SetOppTextColour (SWI &40762). See PRM 3-403."""
    return external_call["ColourTrans_SetOppTextColour", Int32](palette_entry, colour)

def set_text_colour(palette_entry: Int32, colour: Int32) -> Int32:
    """ColourTrans_SetTextColour (SWI &40761). See PRM 3-401."""
    return external_call["ColourTrans_SetTextColour", Int32](palette_entry, colour)

def write_calibration_to_file(flags: Int32, file: Int32) -> None:
    """ColourTrans_WriteCalibrationToFile (SWI &40757). See PRM 3-383."""
    _ = external_call["ColourTrans_WriteCalibrationToFile", Int32](flags, file)

def write_loadings_to_file(file: Int32) -> None:
    """ColourTrans_WriteLoadingsToFile (SWI &40760). See PRM 3-400."""
    _ = external_call["ColourTrans_WriteLoadingsToFile", Int32](file)
