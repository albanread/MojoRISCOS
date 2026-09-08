# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: a typo'd method name is a compile error, not a runtime mystery.
from std.sys._com import ComPtr
from std.sys.com import Com


def main() raises:
    let p = ComPtr[StaticString("IStream")](adopt=0)
    let s = Com[StaticString("IStream")](of=p)
    _ = s.Wrlte(UInt32(0))  # misspelled Write
