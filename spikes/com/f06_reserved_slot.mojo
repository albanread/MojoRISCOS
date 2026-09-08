# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: the IUnknown slots belong to the library; a class may not
# supply its own AddRef. The builder rejects it at compile time.
from std.sys.com import ComClassBuilder


fn my_add_ref(this: Int) -> UInt32:
    return 1


def main() raises:
    var b = ComClassBuilder[StaticString("IDropTarget")]()
    b.slot["AddRef", def (Int) thin abi("C") -> UInt32](my_add_ref)
    _ = b^.finish()
