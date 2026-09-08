# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: Drop takes four parameters on IDropTarget; this one declares
# three. Without the check it compiles and half-works: Win64 is caller
# cleanup, so OLE's fourth argument is silently ignored, the call returns
# S_OK, and the DROPEFFECT out-parameter is never written -- a drag that
# looks accepted and does nothing.
class ShortDrop(IDropTarget):
    var drops: Int

    def DragEnter(mut self, d: Int, k: UInt32, p: Int, e: Int) raises:
        pass

    def DragOver(mut self, k: UInt32, p: Int, e: Int) raises:
        pass

    def DragLeave(mut self) raises:
        pass

    def Drop(mut self, d: Int, k: UInt32, p: Int) raises:
        self.drops += 1


def main() raises:
    var obj = ShortDrop(0).into_com()
    _ = obj
    print("must not compile")
