# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: the SDK declares Read with three parameters; two is an error.
from std.memory import Pointer
from std.sys._com import ComPtr
from std.sys.com import Com


def main() raises:
    let p = ComPtr[StaticString("IStream")](adopt=0)
    let s = Com[StaticString("IStream")](of=p)
    var n = UInt32(0)
    _ = s.Read(Pointer(to=n).unsafe_origin_cast[MutAnyOrigin](), UInt32(4))
