

# ------------- hand-written natural overloads -------------

def write0(msg: StringLiteral):
    """Writes a string literal to all active output streams (OS_Write0)."""
    _ = external_call["os_write0", Int32](msg.ptr())

def write_s(msg: StringLiteral):
    """Writes a literal (no newline) to the output stream."""
    _ = external_call["os_write0", Int32](msg.ptr())
