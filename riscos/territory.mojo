"""RISC OS Territory SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_territory.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def alphabet(territory: Int32) -> Int32:
    """Territory_Alphabet (SWI &43052). See PRM 3-829."""
    return external_call["Territory_Alphabet", Int32](territory)

def alphabet_identifier(territory: Int32) -> Int32:
    """Territory_AlphabetIdentifier (SWI &43053). See PRM 3-830."""
    return external_call["Territory_AlphabetIdentifier", Int32](territory)

def alphabet_number_to_name(alphabet: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_AlphabetNumberToName (SWI &43045). See PRM 3-806."""
    _ = external_call["Territory_AlphabetNumberToName", Int32](alphabet, buffer, length)

def character_property_table(territory: Int32, code: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Territory_CharacterPropertyTable (SWI &43056). See PRM 3-834."""
    return external_call["Territory_CharacterPropertyTable", Int32](territory, code)

def collate(territory: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin], string2: UnsafePointer[UInt8, MutUntrackedOrigin], flags: Int32) -> Int32:
    """Territory_Collate (SWI &4305D). See PRM 3-842."""
    return external_call["Territory_Collate", Int32](territory, string, string2, flags)

def control_table(territory: Int32) -> Int32:
    """Territory_ControlTable (SWI &43059). See PRM 3-838."""
    return external_call["Territory_ControlTable", Int32](territory)

def convert_ordinals_to_time(territory: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], block2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_ConvertOrdinalsToTime (SWI &43051). See PRM 3-827."""
    _ = external_call["Territory_ConvertOrdinalsToTime", Int32](territory, block, block2)

def convert_standard_date(territory: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Territory_ConvertStandardDate (SWI &4304D). See PRM 3-819."""
    return external_call["Territory_ConvertStandardDate", Int32](territory, ptr, string, size)

def convert_standard_date_and_time(territory: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Territory_ConvertStandardDateAndTime (SWI &4304C). See PRM 3-817."""
    return external_call["Territory_ConvertStandardDateAndTime", Int32](territory, ptr, string, size)

def convert_standard_time(territory: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Territory_ConvertStandardTime (SWI &4304E). See PRM 3-821."""
    return external_call["Territory_ConvertStandardTime", Int32](territory, ptr, string, size)

def convert_text_to_string() -> None:
    """Territory_ConvertTextToString (SWI &43075). See PRM 3-812."""
    _ = external_call["Territory_ConvertTextToString", Int32]()

def convert_time_to_ordinals(territory: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_ConvertTimeToOrdinals (SWI &4304F). See PRM 3-823."""
    _ = external_call["Territory_ConvertTimeToOrdinals", Int32](territory, ptr, buffer)

def convert_time_to_utcordinals(ptr: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_ConvertTimeToUTCOrdinals (SWI &43049). See PRM 3-810."""
    _ = external_call["Territory_ConvertTimeToUTCOrdinals", Int32](ptr, buffer)

def deregister(territory: Int32) -> None:
    """Territory_Deregister (SWI &43042). See PRM 3-803."""
    _ = external_call["Territory_Deregister", Int32](territory)

def exists(territory: Int32) -> None:
    """Territory_Exists (SWI &43044). See PRM 3-805."""
    _ = external_call["Territory_Exists", Int32](territory)

def lower_case_table(territory: Int32) -> Int32:
    """Territory_LowerCaseTable (SWI &43057). See PRM 3-836."""
    return external_call["Territory_LowerCaseTable", Int32](territory)

def name_to_number(territory: Int32, territory2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Territory_NameToNumber (SWI &43060). See PRM 3-849."""
    return external_call["Territory_NameToNumber", Int32](territory, territory2)

def number() -> Int32:
    """Territory_Number (SWI &43040). See PRM 3-800."""
    return external_call["Territory_Number", Int32]()

def number_to_name(territory: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_NumberToName (SWI &43043). See PRM 3-804."""
    _ = external_call["Territory_NumberToName", Int32](territory, buffer, length)

def plain_table(territory: Int32) -> Int32:
    """Territory_PlainTable (SWI &4305A). See PRM 3-839."""
    return external_call["Territory_PlainTable", Int32](territory)

def read_calendar_information(territory: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_ReadCalendarInformation (SWI &4305F). See PRM 3-847."""
    _ = external_call["Territory_ReadCalendarInformation", Int32](territory, ptr, buffer)

def read_current_time_zone(out_offset: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Territory_ReadCurrentTimeZone (SWI &43048). See PRM 3-809."""
    return external_call["Territory_ReadCurrentTimeZone", Int32](out_offset)

def read_time_zones(territory: Int32, out_name: UnsafePointer[Int32, MutUntrackedOrigin], out_offset: UnsafePointer[Int32, MutUntrackedOrigin], out_offset2: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Territory_ReadTimeZones (SWI &4304A). See PRM 3-814."""
    return external_call["Territory_ReadTimeZones", Int32](territory, out_name, out_offset, out_offset2)

def register(territory: Int32, ptr: UnsafePointer[UInt8, MutUntrackedOrigin], territory2: Int32) -> None:
    """Territory_Register (SWI &43041). See PRM 3-801."""
    _ = external_call["Territory_Register", Int32](territory, ptr, territory2)

def representation_table(territory: Int32) -> Int32:
    """Territory_RepresentationTable (SWI &4305C). See PRM 3-841."""
    return external_call["Territory_RepresentationTable", Int32](territory)

def select_alphabet(territory: Int32) -> None:
    """Territory_SelectAlphabet (SWI &43046). See PRM 3-807."""
    _ = external_call["Territory_SelectAlphabet", Int32](territory)

def select_keyboard_handler(territory: Int32) -> None:
    """Territory_SelectKeyboardHandler (SWI &43054). See PRM 3-831."""
    _ = external_call["Territory_SelectKeyboardHandler", Int32](territory)

def set_time(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Territory_SetTime (SWI &43047). See PRM 3-808."""
    _ = external_call["Territory_SetTime", Int32](ptr)

def transform_string(territory: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin], string2: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """Territory_TransformString (SWI &43061). See PRM 3-850."""
    return external_call["Territory_TransformString", Int32](territory, string, string2, length)

def upper_case_table(territory: Int32) -> Int32:
    """Territory_UpperCaseTable (SWI &43058). See PRM 3-837."""
    return external_call["Territory_UpperCaseTable", Int32](territory)

def value_table(territory: Int32) -> Int32:
    """Territory_ValueTable (SWI &4305B). See PRM 3-840."""
    return external_call["Territory_ValueTable", Int32](territory)

def write_direction(territory: Int32) -> Int32:
    """Territory_WriteDirection (SWI &43055). See PRM 3-832."""
    return external_call["Territory_WriteDirection", Int32](territory)
