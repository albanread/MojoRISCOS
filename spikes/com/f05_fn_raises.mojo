# Copyright (c) 2026, Alban Read.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# See LICENSE in the root of this repository, or https://llvm.org/LICENSE.txt

# MUST FAIL: fn is the foreign-callable contract; raising across a C boundary
# is exactly what it exists to forbid.
fn bad_callback(x: Int) raises -> Int:
    if x == 0:
        raise Error("no")
    return x


def main() raises:
    _ = bad_callback(1)
