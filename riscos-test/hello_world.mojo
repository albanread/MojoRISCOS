"""Hello world, written the way the objective says programs must be written.

No `external_call`, no SWI, no register named anywhere: the only thing this
knows is that `riscos.os` has a function for putting a string on the screen.
The C shim behind that function is the one place a SWI is issued, so the day
the call mechanism changes this file does not.

Compare riscos-test/hello_print.mojo, which reaches straight into rostrt
with external_call["os_write0"] - that works, and it is exactly what the
library exists to stop.
"""

from riscos import os


fn main():
    os.write0("Hello RISC OS, from Mojo.\n")
    os.write0("Built on the host, run on the Pi 4.\n")
