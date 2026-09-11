"""RISC OS OS SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_os.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def add_call_back(address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_AddCallBack (SWI &54). See PRM 1-326."""
    _ = external_call["OS_AddCallBack", Int32](address, value)

def add_to_vector(vector: Int32, address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_AddToVector (SWI &47). See PRM 1-72."""
    _ = external_call["OS_AddToVector", Int32](vector, address, value)

def bget(file: Int32) -> Int32:
    """OS_BGet (SWI &A). See PRM 2-63."""
    return external_call["OS_BGet", Int32](file)

def bput(byte: Int32, file: Int32) -> None:
    """OS_BPut (SWI &B). See PRM 2-65."""
    _ = external_call["OS_BPut", Int32](byte, file)

def binary_to_decimal(signed_: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: Int32) -> Int32:
    """OS_BinaryToDecimal (SWI &28). See PRM 1-470."""
    return external_call["OS_BinaryToDecimal", Int32](signed_, buffer, length)

def break_ctrl(block: UnsafePointer[UInt8, MutUntrackedOrigin], handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_BreakCtrl (SWI &18). See PRM 1-312."""
    _ = external_call["OS_BreakCtrl", Int32](block, handle)

def break_pt() -> None:
    """OS_BreakPt (SWI &17). See PRM 1-311."""
    _ = external_call["OS_BreakPt", Int32]()

def byte(os_byte: Int32, arg1: Int32) -> Int32:
    """OS_Byte (SWI &6). See PRM 1-54."""
    return external_call["OS_Byte", Int32](os_byte, arg1)

def cli(string: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_CLI (SWI &5). See PRM 1-963."""
    _ = external_call["OS_CLI", Int32](string)

def crc(value: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin], block2: UnsafePointer[UInt8, MutUntrackedOrigin], increment: Int32) -> Int32:
    """OS_CRC (SWI &5B). See PRM 1-977."""
    return external_call["OS_CRC", Int32](value, block, block2, increment)

def call_after(time: Int32, address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_CallAfter (SWI &3B). See PRM 1-443."""
    _ = external_call["OS_CallAfter", Int32](time, address, value)

def call_back(block: UnsafePointer[UInt8, MutUntrackedOrigin], handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_CallBack (SWI &15). See PRM 1-309."""
    _ = external_call["OS_CallBack", Int32](block, handle)

def call_every(delay: Int32, address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_CallEvery (SWI &3C). See PRM 1-445."""
    _ = external_call["OS_CallEvery", Int32](delay, address, value)

def change_dynamic_area(area: Int32, amount: Int32) -> Int32:
    """OS_ChangeDynamicArea (SWI &2A). See PRM 1-386."""
    return external_call["OS_ChangeDynamicArea", Int32](area, amount)

def change_environment(handle: Int32, handle2: UnsafePointer[UInt8, MutUntrackedOrigin], handle3: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """OS_ChangeEnvironment (SWI &40). See PRM 1-322."""
    return external_call["OS_ChangeEnvironment", Int32](handle, handle2, handle3, buffer)

def change_redirection(arg0: Int32, string: Int32) -> Int32:
    """OS_ChangeRedirection (SWI &5E). See PRM 1-966."""
    return external_call["OS_ChangeRedirection", Int32](arg0, string)

def changed_box(arg0: Int32, out_block: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ChangedBox (SWI &5A). See PRM 1-754."""
    return external_call["OS_ChangedBox", Int32](arg0, out_block)

def check_mode_valid(mode: Int32) -> Int32:
    """OS_CheckModeValid (SWI &3F). See PRM 1-744."""
    return external_call["OS_CheckModeValid", Int32](mode)

def claim(vector: Int32, address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_Claim (SWI &1F). See PRM 1-66."""
    _ = external_call["OS_Claim", Int32](vector, address, value)

def claim_screen_memory(arg0: Int32, length: Int32, out_address: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ClaimScreenMemory (SWI &41). See PRM 1-390."""
    return external_call["OS_ClaimScreenMemory", Int32](arg0, length, out_address)

def confirm() -> Int32:
    """OS_Confirm (SWI &59). See PRM 1-975."""
    return external_call["OS_Confirm", Int32]()

def control(handle: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin], handle2: UnsafePointer[UInt8, MutUntrackedOrigin], handle3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_Control (SWI &F). See PRM 1-301."""
    _ = external_call["OS_Control", Int32](handle, buffer, handle2, handle3)

def convert_date_and_time(block: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin], string2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ConvertDateAndTime (SWI &C1). See PRM 1-451."""
    _ = external_call["OS_ConvertDateAndTime", Int32](block, string, size, string2)

def convert_file_size(size: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """OS_ConvertFileSize (SWI &EC). See PRM 1-494."""
    return external_call["OS_ConvertFileSize", Int32](size, buffer, length)

def convert_fixed_file_size(size: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """OS_ConvertFixedFileSize (SWI &EB). See PRM 1-492."""
    return external_call["OS_ConvertFixedFileSize", Int32](size, buffer, length)

def convert_fixed_net_station(block: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ConvertFixedNetStation (SWI &E9). See PRM 1-488."""
    _ = external_call["OS_ConvertFixedNetStation", Int32](block, string, size)

def convert_net_station(block: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ConvertNetStation (SWI &EA). See PRM 1-490."""
    _ = external_call["OS_ConvertNetStation", Int32](block, string, size)

def convert_standard_date_and_time(block: UnsafePointer[UInt8, MutUntrackedOrigin], string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ConvertStandardDateAndTime (SWI &C0). See PRM 1-449."""
    _ = external_call["OS_ConvertStandardDateAndTime", Int32](block, string, size)

def delink_application(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_DelinkApplication (SWI &4D). See PRM 1-74."""
    _ = external_call["OS_DelinkApplication", Int32](buffer, size)

def enter_os(arg0: Int32, event: Int32) -> Int32:
    """OS_EnterOS (SWI &16). See PRM 1-141."""
    return external_call["OS_EnterOS", Int32](arg0, event)

def evaluate_expression(string: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_EvaluateExpression (SWI &2D). See PRM 1-472."""
    _ = external_call["OS_EvaluateExpression", Int32](string, buffer, length)

def exit(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], abex: Int32, return_: Int32) -> None:
    """OS_Exit (SWI &11). See PRM 1-305."""
    _ = external_call["OS_Exit", Int32](buffer, abex, return_)

def exit_and_die(buffer: UnsafePointer[UInt8, MutUntrackedOrigin], abex: Int32, return_: Int32, module: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ExitAndDie (SWI &50). See PRM 1-325."""
    _ = external_call["OS_ExitAndDie", Int32](buffer, abex, return_, module)

def gsinit(string: UnsafePointer[UInt8, MutUntrackedOrigin], flags: Int32, out_value: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_GSInit (SWI &25). See PRM 1-464."""
    return external_call["OS_GSInit", Int32](string, flags, out_value)

def gsread(arg0: Int32, arg2: Int32, out_next: UnsafePointer[Int32, MutUntrackedOrigin], out_string: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_GSRead (SWI &26). See PRM 1-466."""
    return external_call["OS_GSRead", Int32](arg0, arg2, out_next, out_string)

def gstrans(string: UnsafePointer[UInt8, MutUntrackedOrigin], buffer: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_GSTrans (SWI &27). See PRM 1-468."""
    _ = external_call["OS_GSTrans", Int32](string, buffer, size)

def generate_error(block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_GenerateError (SWI &2B). See PRM 1-45."""
    _ = external_call["OS_GenerateError", Int32](block)

def get_env(out_address: UnsafePointer[Int32, MutUntrackedOrigin], out_ptr: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_GetEnv (SWI &10). See PRM 1-303."""
    return external_call["OS_GetEnv", Int32](out_address, out_ptr)

def install_key_handler() -> None:
    """OS_InstallKeyHandler (SWI &3E). See PRM 1-948."""
    _ = external_call["OS_InstallKeyHandler", Int32]()

def int_off() -> None:
    """OS_IntOff (SWI &14). See PRM 1-140."""
    _ = external_call["OS_IntOff", Int32]()

def int_on() -> None:
    """OS_IntOn (SWI &13). See PRM 1-139."""
    _ = external_call["OS_IntOn", Int32]()

def mouse(out_y: UnsafePointer[Int32, MutUntrackedOrigin], out_mouse: UnsafePointer[Int32, MutUntrackedOrigin], out_time: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_Mouse (SWI &1C). See PRM 1-728."""
    return external_call["OS_Mouse", Int32](out_y, out_mouse, out_time)

def plot(plot: Int32, x: Int32, y: Int32) -> None:
    """OS_Plot (SWI &45). See PRM 1-746."""
    _ = external_call["OS_Plot", Int32](plot, x, y)

def pretty_print(string: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin], string2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_PrettyPrint (SWI &44). See PRM 1-538."""
    _ = external_call["OS_PrettyPrint", Int32](string, ptr, string2)

def print_char(character: Int32) -> None:
    """OS_PrintChar (SWI &5D). See PRM 1-541."""
    _ = external_call["OS_PrintChar", Int32](character)

def read_args(value: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin], size: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """OS_ReadArgs (SWI &49). See PRM 1-482."""
    return external_call["OS_ReadArgs", Int32](value, string, size)

def read_dynamic_area(area: Int32, out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ReadDynamicArea (SWI &5C). See PRM 1-398."""
    return external_call["OS_ReadDynamicArea", Int32](area, out_count)

def read_escape_state() -> None:
    """OS_ReadEscapeState (SWI &2C). See PRM 1-945."""
    _ = external_call["OS_ReadEscapeState", Int32]()

def read_mem_map_entries(buffer: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ReadMemMapEntries (SWI &52). See PRM 1-394."""
    _ = external_call["OS_ReadMemMapEntries", Int32](buffer)

def read_mem_map_info(out_count: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ReadMemMapInfo (SWI &51). See PRM 1-393."""
    return external_call["OS_ReadMemMapInfo", Int32](out_count)

def read_mode_variable(mode: Int32, variable: Int32) -> Int32:
    """OS_ReadModeVariable (SWI &35). See PRM 1-738."""
    return external_call["OS_ReadModeVariable", Int32](mode, variable)

def read_monotonic_time() -> Int32:
    """OS_ReadMonotonicTime (SWI &42). See PRM 1-448."""
    return external_call["OS_ReadMonotonicTime", Int32]()

def read_palette(colour: Int32, colour2: Int32, out_colour: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ReadPalette (SWI &2F). See PRM 1-730."""
    return external_call["OS_ReadPalette", Int32](colour, colour2, out_colour)

def read_point(x: Int32, y: Int32, out_tint: UnsafePointer[Int32, MutUntrackedOrigin], out_flags: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ReadPoint (SWI &32). See PRM 1-736."""
    return external_call["OS_ReadPoint", Int32](x, y, out_tint, out_flags)

def read_ramfs_limits(out_address: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_ReadRAMFsLimits (SWI &4A). See PRM 1-392."""
    return external_call["OS_ReadRAMFsLimits", Int32](out_address)

def read_unsigned(flags: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> Int32:
    """OS_ReadUnsigned (SWI &21). See PRM 1-462."""
    return external_call["OS_ReadUnsigned", Int32](flags, string, value)

def read_vdu_variables(block: UnsafePointer[UInt8, MutUntrackedOrigin], block2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ReadVduVariables (SWI &31). See PRM 1-732."""
    _ = external_call["OS_ReadVduVariables", Int32](block, block2)

def release(vector: Int32, address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_Release (SWI &20). See PRM 1-68."""
    _ = external_call["OS_Release", Int32](vector, address, value)

def remove_call_back() -> None:
    """OS_RemoveCallBack (SWI &5F). See PRM 1-330."""
    _ = external_call["OS_RemoveCallBack", Int32]()

def remove_cursors() -> None:
    """OS_RemoveCursors (SWI &36). See PRM 1-741."""
    _ = external_call["OS_RemoveCursors", Int32]()

def remove_ticker_event(address: UnsafePointer[UInt8, MutUntrackedOrigin], value: Int32) -> None:
    """OS_RemoveTickerEvent (SWI &3D). See PRM 1-447."""
    _ = external_call["OS_RemoveTickerEvent", Int32](address, value)

def restore_cursors() -> None:
    """OS_RestoreCursors (SWI &37). See PRM 1-743."""
    _ = external_call["OS_RestoreCursors", Int32]()

def swinumber_from_string(name: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """OS_SWINumberFromString (SWI &39). See PRM 1-476."""
    return external_call["OS_SWINumberFromString", Int32](name)

def swinumber_to_string(swi: Int32, buffer: UnsafePointer[UInt8, MutUntrackedOrigin], length: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_SWINumberToString (SWI &38). See PRM 1-474."""
    _ = external_call["OS_SWINumberToString", Int32](swi, buffer, length)

def service_call(service: Int32) -> None:
    """OS_ServiceCall (SWI &30). See PRM 1-256."""
    _ = external_call["OS_ServiceCall", Int32](service)

def set_call_back() -> None:
    """OS_SetCallBack (SWI &1B). See PRM 1-315."""
    _ = external_call["OS_SetCallBack", Int32]()

def set_colour(colour: Int32, colour2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_SetColour (SWI &61). See PRM 1-756."""
    _ = external_call["OS_SetColour", Int32](colour, colour2)

def set_ecforigin(x: Int32, y: Int32) -> None:
    """OS_SetECFOrigin (SWI &56). See PRM 1-747."""
    _ = external_call["OS_SetECFOrigin", Int32](x, y)

def set_mem_map_entries(ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_SetMemMapEntries (SWI &53). See PRM 1-396."""
    _ = external_call["OS_SetMemMapEntries", Int32](ptr)

def unused_swi(handle: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_UnusedSWI (SWI &19). See PRM 1-314."""
    _ = external_call["OS_UnusedSWI", Int32](handle)

def update_memc(new: Int32, mask: Int32, out_mask: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """OS_UpdateMEMC (SWI &1A). See PRM 1-375."""
    return external_call["OS_UpdateMEMC", Int32](new, mask, out_mask)

def validate_address(address: UnsafePointer[UInt8, MutUntrackedOrigin], address2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_ValidateAddress (SWI &3A). See PRM 1-388."""
    _ = external_call["OS_ValidateAddress", Int32](address, address2)

def write0(string: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_Write0 (SWI &2). See PRM 1-30."""
    _ = external_call["OS_Write0", Int32](string)

def write_c(character: Int32) -> None:
    """OS_WriteC (SWI &0). See PRM 1-517."""
    _ = external_call["OS_WriteC", Int32](character)

def write_env(string: UnsafePointer[UInt8, MutUntrackedOrigin], ptr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """OS_WriteEnv (SWI &48). See PRM 1-324."""
    _ = external_call["OS_WriteEnv", Int32](string, ptr)

def write_n(string: UnsafePointer[UInt8, MutUntrackedOrigin], count: Int32) -> None:
    """OS_WriteN (SWI &46). See PRM 1-542."""
    _ = external_call["OS_WriteN", Int32](string, count)

def write_s() -> None:
    """OS_WriteS (SWI &1). See PRM 1-519."""
    _ = external_call["OS_WriteS", Int32]()



# ------------- hand-written natural overloads -------------

def write0(msg: StringLiteral):
    """Writes a string literal to all active output streams (OS_Write0)."""
    _ = external_call["os_write0", Int32](msg.ptr())

def write_s(msg: StringLiteral):
    """Writes a literal (no newline) to the output stream."""
    _ = external_call["os_write0", Int32](msg.ptr())
