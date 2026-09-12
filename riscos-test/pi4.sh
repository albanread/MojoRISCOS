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

for name in "$@"; do
    printf '%-14s ' "$name"

    if ! "$MOJO" build --emit object \
            --target-triple $TRIPLE --target-cpu $CPU \
            --target-features +strict-align \
            -I "$ROOT/mojo/stdlib" -I "$ROOT" -I "$ROOT/riscos-test" \
            -o "build/$name.o" "$name.mojo" 2>"build/$name.log"; then
        echo "COMPILE FAILED - riscos-test/build/$name.log"
        grep -m3 "error:" "build/$name.log" | sed 's/^/    /'
        exit 1
    fi

    if ! "$ROSCC" link --entry _start -o "${name}_$TAG,ff8" \
            "$RT/crt0-$TAG.o" "build/$name.o" \
            "$RT/rostrt-$TAG.o" "$RT/wimp-$TAG.o" \
            "$RT/swis_os-$TAG.o" "$RT/swis_wimp-$TAG.o" \
            "$RT/aeabi-$TAG.o" "$RT/atomics-$TAG.o" >"build/$name.link" 2>&1; then
        echo "LINK FAILED"
        grep -m3 -iE "undefined|error" "build/$name.link" | sed 's/^/    /'
        exit 1
    fi

    printf 'ok %7d bytes' "$(stat -c%s "${name}_$TAG,ff8")"

    if [ -n "$TO" ]; then
        leaf=${AS:-$name}
        share="$FARM/$TO/share"
        [ -d "$share" ] || { echo; echo "no share at $share" >&2; exit 1; }
        cp "${name}_$TAG,ff8" "$share/$leaf,ff8"
        printf '  -> %s/%s,ff8' "$TO" "$leaf"
    fi
    echo
done
