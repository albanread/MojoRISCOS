"""RISC OS ColourPicker SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_colour_picker.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def close_dialogue(flags: Int32, handle: Int32) -> None:
    """ColourPicker_CloseDialogue (SWI &47703). See PRM 5a-566."""
    _ = external_call["ColourPicker_CloseDialogue", Int32](flags, handle)

def deregister_model() -> None:
    """ColourPicker_DeregisterModel (SWI &47701). See PRM 5a-561."""
    _ = external_call["ColourPicker_DeregisterModel", Int32]()

def help_reply(flags: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> None:
    """ColourPicker_HelpReply (SWI &47707). See PRM 5a-572."""
    _ = external_call["ColourPicker_HelpReply", Int32](flags, block)

def model_swi() -> None:
    """ColourPicker_ModelSWI (SWI &47708). See PRM 5a-574."""
    _ = external_call["ColourPicker_ModelSWI", Int32]()

def open_dialogue(flags: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourPicker_OpenDialogue (SWI &47702). See PRM 5a-563."""
    return external_call["ColourPicker_OpenDialogue", Int32](flags, block)

def read_dialogue(flags: Int32, handle: Int32, block: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ColourPicker_ReadDialogue (SWI &47705). See PRM 5a-569."""
    return external_call["ColourPicker_ReadDialogue", Int32](flags, handle, block)

def register_model() -> None:
    """ColourPicker_RegisterModel (SWI &47700). See PRM 5a-561."""
    _ = external_call["ColourPicker_RegisterModel", Int32]()

def set_colour() -> None:
    """ColourPicker_SetColour (SWI &47706). See PRM 5a-571."""
    _ = external_call["ColourPicker_SetColour", Int32]()

def update_dialogue() -> None:
    """ColourPicker_UpdateDialogue (SWI &47704). See PRM 5a-568."""
    _ = external_call["ColourPicker_UpdateDialogue", Int32]()
