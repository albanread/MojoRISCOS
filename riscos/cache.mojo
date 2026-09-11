"""RISC OS Cache SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_cache.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def cacheable(mask: Int32, mask2: Int32) -> Int32:
    """Cache_Cacheable (SWI &281). See PRM 4-194."""
    return external_call["Cache_Cacheable", Int32](mask, mask2)

def control(mask: Int32, mask2: Int32) -> Int32:
    """Cache_Control (SWI &280). See PRM 4-192."""
    return external_call["Cache_Control", Int32](mask, mask2)

def disruptive(mask: Int32, mask2: Int32) -> Int32:
    """Cache_Disruptive (SWI &283). See PRM 4-198."""
    return external_call["Cache_Disruptive", Int32](mask, mask2)

def flush() -> None:
    """Cache_Flush (SWI &284). See PRM 4-200."""
    _ = external_call["Cache_Flush", Int32]()

def updateable(mask: Int32, mask2: Int32) -> Int32:
    """Cache_Updateable (SWI &282). See PRM 4-196."""
    return external_call["Cache_Updateable", Int32](mask, mask2)
