"""RISC OS bindings for Mojo - generated from the PRM database plus
hand-written idiomatic layers. Import as:

    from riscos import os, wimp, clib

Generated modules: 45 PRM modules plus the C library surface (clib,
from clib.json — the portable layer: Mojo code should prefer it over
SWIs so it survives RISC OS version changes).
"""

from . import adfs
from . import basictrans
from . import buffer
from . import cache
from . import clib
from . import colour_picker
from . import colour_trans
from . import compress_jpeg
from . import debugger
from . import device_fs
from . import dma
from . import dosfs
from . import drag_an_object
from . import drag_asprite
from . import draw
from . import draw_file
from . import econet
from . import file_core
from . import filer_action
from . import filter
from . import font
from . import fpemulator
from . import fslock
from . import hourglass
from . import iic
from . import joystick
from . import jpeg
from . import make_psfont
from . import message_trans
from . import net_fs
from . import net_print
from . import os
from . import parallel
from . import pdriver
from . import pdumper
from . import podule
from . import portable
from . import ram_fs
from . import resource_fs
from . import screen_blanker
from . import shared_clibrary
from . import shell
from . import sound
from . import task_manager
from . import territory
from . import wimp
