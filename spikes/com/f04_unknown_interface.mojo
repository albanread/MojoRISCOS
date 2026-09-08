# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: an interface the metadata does not know cannot be spoken to.
from std.sys._com import ComPtr
from std.sys.com import Com


def main() raises:
    let p = ComPtr[StaticString("IStreem")](adopt=0)  # misspelled IStream
    let s = Com[StaticString("IStreem")](of=p)
    _ = s.Read(UInt32(0))
