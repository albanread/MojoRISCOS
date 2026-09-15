> [!CAUTION]
> 🛑 **REPOSITORY CLOSED — UNMAINTAINED.**
>
> Do not assume the reliability of any data in this repository. It will be
> archived on **15 October 2026**.

# mojo-riscos — Mojo for RISC OS 5 on 32-bit ARM

![NEW EXPERIMENT](https://img.shields.io/badge/NEW_EXPERIMENT-c1121f?style=for-the-badge&labelColor=c1121f)

> [!CAUTION]
> **NEW EXPERIMENT.** This is an unaffiliated research fork, days old, and
> nothing in it is finished or supported. Demos build; most have not yet been
> run on real hardware. Do not depend on any of it, and do not report anything
> about it to Modular — see below.

Teaching the Mojo compiler to emit code for **RISC OS 5 in 32-bit ARM**: the
StrongARM RiscPC that RPCEmu emulates, and the Raspberry Pi 4's Cortex-A72
running RISC OS in AArch32. Not a bridge, not a transpiler — `mojo` builds an
object file for the target directly, and the result is a RISC OS Absolute or
AIF image you can double-click.

A Wimp application, written in Mojo, compiled by Mojo:

```mojo
var window = wimp.simple_window("Hello", "Mojo on RISC OS 5")
var block = wimp.PollBlock()
while running:
    let event = wimp.poll(0, block)
    if event == wimp.OPEN_WINDOW_REQUEST:
        wimp.open_window_from_poll(block)
    elif event == wimp.CLOSE_WINDOW_REQUEST:
        running = False
```

---

## This is not Modular's project

**Please do not take anything about this fork to Modular.** They did not write
it, have not seen it, are not responsible for it and cannot help with it. No
affiliation, no endorsement, no shared maintenance — just their Apache-licensed
source, taken in the direction the licence allows.

- A bug in **Mojo, the standard library or MAX** → [modular/modular](https://github.com/modular/modular).
  Reproduce it against a stock Mojo build first. If it only breaks here, it is
  mine, not theirs.
- Anything about **RISC OS, this port, or these bindings** →
  [here](https://github.com/albanread/MojoRISCOS/issues). Never there.

That Modular open-sourced the compiler and standard library under Apache 2.0
with LLVM exceptions — a patent grant, no field-of-use restriction, no hardware
limits on the source — is the only reason this work is possible. Aiming a
language at a 1987 desktop operating system is not a use case anybody owes you,
and against a closed compiler it would not have been a long job, it would have
been an impossible one. The respectful way to accept that is to keep the
consequences of this fork entirely on this side of the fence.

Upstream base is commit `f66d4d52`. See [NOTICE](NOTICE) for attribution and
the statement of changes, and [CONTRIBUTING.md](CONTRIBUTING.md) for where a
given change actually belongs.

---

## Two targets, both first-class

RPCEmu emulates RiscPC-class hardware — StrongARM SA110, ARMv4 at newest — so
it cannot run A72 code. The classic RISC OS build model applies: compile for
ARMv4 to run anywhere, for the A72 when you want the Pi to work for a living.

| Profile | CPU | Where | Constraints |
| --- | --- | --- | --- |
| `riscos-sa` | `strongarm110`, ARMv4 | RPCEmu sandbox | soft-float, no unaligned load/store, no `movw`/`movt` (literal pools), no hardware divide, ARM state only |
| `riscos-a72` | `cortex-a72`, ARMv8-A AArch32 | Raspberry Pi 4 | VFPv4/NEON via `VFPSupport` (RISC OS 5.28+), CRC and crypto available |

One runtime serves both: `rostrt` carries the ARMv4 division family
(`__aeabi_idiv`, `__aeabi_uidivmod`, the `ldivmod` pair) as hand-written
restoring division, fuzzed against native semantics.

## What works

**The ARM backend.** LLVM is fetched by Bazel rather than vendored, and its
backend list is configuration — adding `"ARM"` to `BACKENDS` and rebuilding
(14,512 actions, about an hour) was the whole change. `mojo build --emit asm
--target-triple armv4-none-eabi --target-cpu strongarm110` emits `.cpu
strongarm110` AArch32 straight from a `.mojo` file, with no external bridge.

**The link to a RISC OS image.** LLVM emits position-zero ELF; the base is
applied at link time by roscc, which reads ELF and writes RISC OS Absolute
(`&FF8`) or AIF at `&8000`. It grew `R_ARM_GOT_PREL` with a synthesised GOT
along the way — Mojo addresses its closures through the GOT even in a static
link — plus `R_ARM_REL32`. First image: `hellomojo,ff8`, 432 bytes of AIF,
crt0 and `OS_Exit` confirmed by disassembly.

**Plain `print()`.** Mojo's print bottoms out at exactly one C symbol —
`write(fd, buf, count)` in `std/io/file_descriptor.mojo` — so `rostrt`
implements it on `OS_WriteC` and the whole formatting layer above comes for
free. Also implemented: `memcpy`, the seven `KGEN_CompilerRT_*` entry points,
SWP and LDREX atomics, and the `fdopen`/`dup`/`fflush` stubs the runtime
expects.

**126 SWIs, generated.** `gen_riscos_pkg.py` reads a SQLite database of the
RISC OS PRM and emits both sides: Mojo bindings in `riscos/` and matching C
shims in `rostrt/`, one function per SWI, named exactly like the SWI so the two
share one contract. 77 OS calls and 49 Wimp calls bind cleanly, with zero
warnings. The generator deliberately skips what it cannot get right —
reason-multiplexed SWIs like the `OS_Byte`/`OS_Word`/`OS_File` families, and
contracts wider than R3 — and those are hand-written instead.

**A real Wimp application.** `riscos-test/wimp_window.mojo` builds a PRM-3-87
indirected window template — title bar, close and back icons, Wimp-redrawn work
area, indirected title and text in arena-lifetime memory — and drives an
ordinary poll loop. Built for both profiles at about 37KB.

One bug worth recording, because it is the kind only a real machine finds:
**RISC OS gives Absolute and AIF images no stack.** The symptom was a data abort
with `r13 = &80000000`, caught by the GDB stub on the
[emulator side](https://github.com/albanread/RPCEMU_INSTRUMENT). `crt0` now
takes the stack from `OS_GetEnv` before calling anything.

## What does not work yet

The demos are **built, not yet run**. `wimpwindow,ff8` and its A72 twin are
waiting on the instrumented emulator to execute them under a debugger, which is
the honest status: the toolchain produces images, and nothing has yet watched
one paint a window.

The driver does not know `--target riscos` either. The chain today is
`mojo --emit object` followed by an explicit `roscc` link; folding that into
`Configuration.cpp` so `mojo build` does it in one step is the open gate.

## Gates

| | | |
| --- | --- | --- |
| **R1** | ARM backend alive in the fetched LLVM | **done** |
| **R2** | `armv8a-unknown-riscos` known to the driver; roscc as linker | open |
| **R3** | stdlib `sys` on SWIs — argv, globals, exit, CompilerRT surface | first cut done |
| **R4** | the Wimp taught to the elaborator, generated from the PRM | done for 126 SWIs |
| **R5** | a Wimp window in Mojo, running in the sandbox and on the Pi | built, not yet run |

Detail, dated and with the reasoning: [RISCOS-PORT.md](RISCOS-PORT.md).

## Not in scope

MAX, the GPU backends, and 64-bit AArch64 RISC OS. MAX is out for a licensing
reason rather than a technical one: it falls under the Modular Community
Licence in `Licenses/`, and this fork stays strictly on the Apache-2.0 compiler
and standard library. Nothing here is built with, extracted from, or derived
from any Modular binary, wheel or account.

## The rest of the tree

This branch also carries a **Windows x64 host port** by the same author — the
axis of where the compiler *runs*, as against what it *emits*. Merged wholesale
because RISC OS work needs a Windows-hosted `mojo.exe` to begin with. See
[WINMOJO.md](WINMOJO.md) and [PORT-JOURNAL.md](PORT-JOURNAL.md); its
boundaries map most of the host assumptions this port also had to move.

Companion projects, both separate repositories:

- **roscc** — Rust and LLVM, ELF in, RISC OS Absolute and AIF out, plus the
  `rostrt` runtime and the SWI binding generator.
- [RPCEMU_INSTRUMENT](https://github.com/albanread/RPCEMU_INSTRUMENT) — RPCEmu
  with breakpoints, watchpoints, tracing, snapshots and a JSON-RPC control
  channel. Where these images get run and debugged.

## Licence

**Apache 2.0 with LLVM Exceptions**, inherited from upstream. Everything added
here carries the same terms.

Almost every file in this tree is still Modular's code, so `LICENSE`,
`Licenses/`, `Licenses/Third-Party-Notices` and the per-file copyright headers
stay exactly as upstream has them — sections 4(a) and 4(c) require it, and it
is the same grant that puts this fork's own additions on a clear footing.
[NOTICE](NOTICE) records what changed. Read the header of a file before
extracting it from this tree; more than one licence lives here.

Mojo, MAX and Modular are Modular's marks. Apache 2.0 grants no trademark
rights, and this fork is not published under them.

I am not a lawyer, and nothing here is legal advice.
