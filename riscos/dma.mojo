"""RISC OS DMA SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_dma.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def deregister_channel(handle: Int32) -> None:
    """DMA_DeregisterChannel (SWI &46141). See PRM 5a-90."""
    _ = external_call["DMA_DeregisterChannel", Int32](handle)

def resume_transfer(flags: Int32, dma: Int32) -> None:
    """DMA_ResumeTransfer (SWI &46145). See PRM 5a-97."""
    _ = external_call["DMA_ResumeTransfer", Int32](flags, dma)

def suspend_transfer(flags: Int32, dma: Int32) -> None:
    """DMA_SuspendTransfer (SWI &46144). See PRM 5a-95."""
    _ = external_call["DMA_SuspendTransfer", Int32](flags, dma)

def terminate_transfer(block: UnsafePointer[UInt8, MutUntrackedOrigin], dma: Int32) -> None:
    """DMA_TerminateTransfer (SWI &46143). See PRM 5a-93."""
    _ = external_call["DMA_TerminateTransfer", Int32](block, dma)
