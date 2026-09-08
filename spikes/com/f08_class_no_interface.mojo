# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: a COM class must name the interface it implements. Without one
# there is no metadata, so no slot indices, so no vtable -- there is nothing to
# guess at, and guessing is what produces objects that crash inside Windows.
class Naked:
    var n: Int
    def Something(mut self) raises:
        pass


def main():
    print("must not compile")
