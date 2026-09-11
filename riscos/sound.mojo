"""RISC OS Sound SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_sound.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def attach_named_voice(channel: Int32, string: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """Sound_AttachNamedVoice (SWI &4018A). See PRM 4-43."""
    _ = external_call["Sound_AttachNamedVoice", Int32](channel, string)

def attach_voice(channel: Int32, voice: Int32) -> Int32:
    """Sound_AttachVoice (SWI &40185). See PRM 4-37."""
    return external_call["Sound_AttachVoice", Int32](channel, voice)

def control(channel: Int32, date: Int32, pitch: Int32, time: Int32) -> None:
    """Sound_Control (SWI &40189). See PRM 4-41."""
    _ = external_call["Sound_Control", Int32](channel, date, pitch, time)

def control_packed(aaaacccc: Int32, ddddpppp: Int32) -> None:
    """Sound_ControlPacked (SWI &40186). See PRM 4-38."""
    _ = external_call["Sound_ControlPacked", Int32](aaaacccc, ddddpppp)

def enable(new: Int32) -> Int32:
    """Sound_Enable (SWI &40141). See PRM 4-20."""
    return external_call["Sound_Enable", Int32](new)

def log_scale(arg0: Int32) -> Int32:
    """Sound_LogScale (SWI &40182). See PRM 4-28."""
    return external_call["Sound_LogScale", Int32](arg0)

def pitch(value: Int32) -> None:
    """Sound_Pitch (SWI &40188). See PRM 4-40."""
    _ = external_call["Sound_Pitch", Int32](value)

def qbeat(length: Int32) -> Int32:
    """Sound_QBeat (SWI &401C6). See PRM 4-54."""
    return external_call["Sound_QBeat", Int32](length)

def qfree() -> Int32:
    """Sound_QFree (SWI &401C3). See PRM 4-51."""
    return external_call["Sound_QFree", Int32]()

def qinit() -> Int32:
    """Sound_QInit (SWI &401C0). See PRM 4-47."""
    return external_call["Sound_QInit", Int32]()

def qinterface() -> None:
    """Sound_QInterface (SWI &401C7). See PRM 4-56."""
    _ = external_call["Sound_QInterface", Int32]()

def qremove() -> None:
    """Sound_QRemove (SWI &401C2). See PRM 4-50."""
    _ = external_call["Sound_QRemove", Int32]()

def qsdispatch() -> None:
    """Sound_QSDispatch (SWI &401C4). See PRM 4-52."""
    _ = external_call["Sound_QSDispatch", Int32]()

def qschedule(schedule: Int32, arg1: Int32, swi: Int32, swi2: Int32) -> Int32:
    """Sound_QSchedule (SWI &401C1). See PRM 4-48."""
    return external_call["Sound_QSchedule", Int32](schedule, arg1, swi, swi2)

def qtempo(new: Int32) -> Int32:
    """Sound_QTempo (SWI &401C5). See PRM 4-53."""
    return external_call["Sound_QTempo", Int32](new)

def read_control_block(channel: Int32, offset: Int32) -> Int32:
    """Sound_ReadControlBlock (SWI &4018B). See PRM 4-44."""
    return external_call["Sound_ReadControlBlock", Int32](channel, offset)

def remove_voice(voice: Int32, out_voice: UnsafePointer[Int32, MutUntrackedOrigin]) -> Int32:
    """Sound_RemoveVoice (SWI &40184). See PRM 4-35."""
    return external_call["Sound_RemoveVoice", Int32](voice, out_voice)

def sound_log(arg0: Int32) -> Int32:
    """Sound_SoundLog (SWI &40181). See PRM 4-27."""
    return external_call["Sound_SoundLog", Int32](arg0)

def speaker(new: Int32) -> Int32:
    """Sound_Speaker (SWI &40143). See PRM 4-24."""
    return external_call["Sound_Speaker", Int32](new)

def stereo(channel: Int32, image: Int32) -> Int32:
    """Sound_Stereo (SWI &40142). See PRM 4-22."""
    return external_call["Sound_Stereo", Int32](channel, image)

def tuning(value: Int32) -> Int32:
    """Sound_Tuning (SWI &40187). See PRM 4-39."""
    return external_call["Sound_Tuning", Int32](value)

def volume(sound: Int32) -> Int32:
    """Sound_Volume (SWI &40180). See PRM 4-26."""
    return external_call["Sound_Volume", Int32](sound)

def write_control_block(channel: Int32, offset: Int32, arg2: Int32) -> Int32:
    """Sound_WriteControlBlock (SWI &4018C). See PRM 4-45."""
    return external_call["Sound_WriteControlBlock", Int32](channel, offset, arg2)
