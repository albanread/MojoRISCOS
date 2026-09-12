#!/bin/bash
# Build RISC OS images for the Raspberry Pi 4, and optionally put one on a
# farm machine.
#
#   riscos-test/pi4.sh hello_world                     build only
#   riscos-test/pi4.sh --to alpha hello_world          build, then into alpha's share
#   riscos-test/pi4.sh --to alpha --as hello hello_world
#
# Same shape as demos/build.sh, retargeted from the StrongARM of the RPCEmu
# sandbox to the Cortex-A72 the QEMU farm runs: armv8a-none-eabi in AArch32,
# +strict-align.  tools/build-rt.sh must have produced the -a72 runtime
# objects in compiler/rostrt/build first.
#
# The share is HostFS, and the `,ff8` on the end of the name is not
# decoration: it is how the file gets its type.  HostFS stores no metadata -
# *Ex shows the leaf verbatim with load and exec both zero, and *SetType on
# it is accepted and silently discarded - but *Run honours the suffix, so
#
#     *Run HostFS:$.hello_world,ff8
#
# in a task window is the whole of the guest side.  No copy to SDFS, no
# *SetType, and no ten-character limit: this image's FileCore takes long
# names.  All four measured on the farm rather than assumed.

set -e
cd "$(dirname "$0")"
ROOT=$(cd .. && pwd)                     # mojo-riscos/
DEV=/f/RISCOSDEV

MOJO="$ROOT/bazel-bin/KGEN/tools/mojo/mojo.exe"
ROSCC="$DEV/compiler/target/debug/roscc.exe"
RT="$DEV/compiler/rostrt/build"
FARM="$DEV/qemu-farm"

TRIPLE=armv8a-none-eabi
CPU=cortex-a72
TAG=a72

# -fpregs, and it is not optional. Ask for a Cortex-A72 and LLVM assumes the
# NEON unit a Cortex-A72 has: it vectorised a stack clear into `vmov.i32 d0,
# #0` + `vst1.64`, and RISC OS - which has not enabled the FP unit for us -
# stopped the program with "Internal error: undefined instruction at
# &000084F4".  The StrongARM demos never saw this because armv4 has no NEON
# to reach for.  -fpregs takes the registers away entirely, so anything
# needing floating point fails to build here rather than at &000084F4.

TO=
AS=
while true; do
    case "$1" in
        --to) TO=$2; shift 2 ;;
        --as) AS=$2; shift 2 ;;
        *) break ;;
    esac
done

[ $# -gt 0 ] || { echo "usage: pi4.sh [--to machine] [--as name] prog..." >&2; exit 2; }

mkdir -p build
failed=0

for name in "$@"; do
    printf '%-14s ' "$name"

    # A demo lives in demos/ and everything else beside this script. The
    # image is written next to its source, so this build and the StrongARM
    # one in demos/build.sh do not overwrite each other.
    if [ -f "demos/$name.mojo" ]; then
        src="demos/$name.mojo"
        out="demos/${name}_$TAG,ff8"
    else
        src="$name.mojo"
        out="${name}_$TAG,ff8"
    fi

    if ! "$MOJO" build --emit object \
            --target-triple $TRIPLE --target-cpu $CPU \
            --target-features +strict-align,-fpregs \
            -I "$ROOT/mojo/stdlib" -I "$ROOT" -I "$ROOT/riscos-test" \
            -o "build/$name.o" "$src" 2>"build/$name.log"; then
        echo "COMPILE FAILED - riscos-test/build/$name.log"
        grep -m3 "error:" "build/$name.log" | sed 's/^/    /'
        failed=$((failed + 1))
        continue
    fi

    if ! "$ROSCC" link --entry _start -o "$out" \
            "$RT/crt0-$TAG.o" "build/$name.o" \
            "$RT/rostrt-$TAG.o" "$RT/wimp-$TAG.o" \
            "$RT/swis_os-$TAG.o" "$RT/swis_wimp-$TAG.o" \
            "$RT/aeabi-$TAG.o" "$RT/atomics-$TAG.o" >"build/$name.link" 2>&1; then
        echo "LINK FAILED"
        grep -m3 -iE "undefined|error" "build/$name.link" | sed 's/^/    /'
        failed=$((failed + 1))
        continue
    fi

    printf 'ok %7d bytes' "$(stat -c%s "$out")"

    if [ -n "$TO" ]; then
        leaf=${AS:-$name}
        share="$FARM/$TO/share"
        [ -d "$share" ] || { echo; echo "no share at $share" >&2; exit 1; }
        cp "$out" "$share/$leaf,ff8"
        printf '  -> %s/%s,ff8' "$TO" "$leaf"
    fi
    echo
done

[ $failed -eq 0 ] || echo "$failed of $# failed"
[ $failed -eq 0 ]
