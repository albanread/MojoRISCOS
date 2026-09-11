# mojo-riscos — Mojo targeting RISC OS 5

A fork of `modular/modular` (base `f66d4d52`, same commit as the WINMOJO
Windows port, so its host patches stay reference-compatible) that teaches
the Mojo compiler to target **RISC OS 5 in 32-bit ARM** — first the
RiscPC-class sandbox in RPCEmu, ultimately the Raspberry Pi 4 (Cortex-A72,
AArch32) — with RISC OS APIs (OS_*, Wimp, Sprite, Font…) as first-class
citizens of the standard library.

Two orthogonal axes:

- **Host**: where the compiler runs — Windows x64 here. WINMOJO
  (`E:\Mojo\WINMOJOX64Blackwell`) already proved a Windows host; its
  PORT-JOURNAL.md is the map of every host-side boundary. Reuse as needed.
- **Target**: what the compiler emits for — `armv8a-...-riscos`,
  AArch32, linked at &8000 into RISC OS Absolute/AIF. This fork's work.

## Assets around the fork

| Asset | Use |
| --- | --- |
| `F:\RISCOSDEV\compiler` (roscc) | Rust+LLVM object writer/linker at &8000, ELF in, Absolute/AIF out |
| `F:\RISCOSDEV\db\riscos_prm.sqlite` | 784 SWIs w/ numbers + register contracts — source for generated APIs |
| `F:\RISCOSDEV\docs\PRM\pdf` | PRM volumes 1–5a + format specs (AIF/AOF/APCS) |
| `F:\RISCOSDEV\rpcemu` | RISC OS 5.30 sandbox (StrongARM) for smoke tests |
| `E:\Mojo\WINMOJOX64Blackwell` | Windows-host port reference (journals document the boundaries) |

## Target matrix

RPCEmu emulates RiscPC-class hardware (StrongARM SA110 = ARMv4 at the
newest) — it cannot run A72 code. Both ends are first-class targets:

| Profile | CPU / arch | Where | Constraints |
| --- | --- | --- | --- |
| `riscos-sa` | `strongarm110`, ARMv4 | RPCEmu sandbox (dev/debug) | soft-float only (no FPU), no unaligned LDR/STR, no movw/movt (literal pools — verified), no SDIV/UDIV (magic-mul for constants, `__aeabi_idiv` etc. in rostrt for variables), ARM state only |
| `riscos-a72` | `cortex-a72`, ARMv8-A AArch32 | Raspberry Pi 4 (deploy) | VFPv4/NEON via `VFPSupport` (RISC OS 5.28+), CRC/crypto available |

Both verified against LLVM's ARM backend (`.cpu strongarm110` /
`.cpu cortex-a72` asm emitted). The classic RISC OS build model applies:
compile `riscos-sa` for run-anywhere binaries (including the sandbox),
`riscos-a72` for optimised Pi builds. roscc's rostrt grows the ARMv4
helpers (`__aeabi_idiv`, `__aeabi_uidivmod`, soft-float ops) so one
runtime serves both.

## Recon results (R0, 2026-09-08)

- LLVM is **fetched by Bazel**, not vendored: `bazel/public-patches/llvm_project.bzl`
  configures it with `BACKENDS = ["AArch64", "RISCV", "X86"]` and already has
  an `extra_targets` tag mechanism. **Adding `"ARM"` is the entire R1 change.**
  (Fetched LLVM at `ec26997e`; KGEN carries bitcode writers for LLVM 17/19/21.)
- Driver: `KGEN/tools/mojo/Build/mojo-build.cpp` — `--target-triple`,
  `--target-cpu`, `--emit asm/llvm/object` all standard; the earlier
  "No available targets are compatible with armv8a-none-eabi" failure came
  from the backend list, not KGEN logic.
- Platform config: `KGEN/lib/Support/Configuration.cpp` (linker selection,
  system library args) — the RISC OS target hooks in here (linker = roscc).
- stdlib OS surface (from WINMOJO journal, still true): `mojo/stdlib/std/sys/`
  (arg, compile, debug, defines, info), `std/os/` (os, process), `std/ffi/`;
  the syscall-coupled set is tiny (`dlopen`×2, `dlsym`×2, `fork`×2,
  `execvp`×1, `unistd`×1) — RISC OS versions go on SWIs.
- Codegen facts already proven from the Windows build's mojo.exe: Mojo's
  `--emit llvm` IR retargets cleanly to Cortex-A72; runtime surface is
  C-ABI `main(argc, argv)` + 7 `KGEN_CompilerRT_*` functions.

## Gate status

- **R1 DONE (2026-09-08).** mojo.exe rebuilt with `extra_targets=["ARM"]`
  (build: 14,512 actions, ~60 min). Verified:
  `--emit asm/--emit object --target-triple armv8a-none-eabi --target-cpu
  cortex-a72` and `--target-triple armv4-none-eabi --target-cpu
  strongarm110` both emit correct AArch32 straight from `.mojo`
  (`.cpu cortex-a72` + crypto-neon-fp-armv8 / `.cpu strongarm110`).
  Full native chain: `hello.mojo -> mojo --emit object -> roscc link ->
  hellomojo,ff8` (AIF, 432 bytes, crt0/main/OS_Exit verified by
  disassembly). roscc's linker gained R_ARM_GOT_PREL (synthesised GOT —
  Mojo addresses its closures via GOT even statically) and R_ARM_REL32.

## Runtime (rostrt) — first cut done (2026-09-08)

`compiler
ostrt\` builds for both profiles (`compiler	oolsuild-rt.sh`):
- `crt0.s` — rostrt_init (argv from OS_GetEnv) -> main -> OS_Exit
- `rostrt.c` — SWI wrappers (OS_WriteC/Write0/GetEnv/Exit) + the 7
  KGEN_CompilerRT functions (globals via a static bump arena)
- `aeabi.s` — ARMv4 division family (__aeabi_{u,}{i,}div{,mod},
  {u,l}divmod): hand-written restoring division, models fuzzed against
  native semantics (`compiler/tools/test_div_model.py`)
Mojo FFI notes: `from std.ffi import external_call`, call as
`_ = external_call["os_write0", Int32](str.ptr())` (void returns modelled
as Int32, discarded). Demo: `riscos-test/hello_print.mojo` ->
`helloprint,ff8` (StrongARM) and `helloprint_a72,ff8` (Pi 4), strings
and fib self-check verified in-image.

## Natural layer (2026-09-09)

`riscos/` Mojo package (generated + hand appendix, `compiler/tools/gen_riscos_pkg.py`
from riscos_prm.sqlite; appendices live in `riscos/appendix_*.mojo` and are
re-appended on regeneration):
- `os` (42 direct bindings + literal overloads), `wimp` (44 bindings; multi-out
  SWIs like Wimp_Poll need hand binding — skipped by the generator on purpose).
- **Plain Mojo `print()` works**: print bottoms at exactly one C symbol
  (`write(fd,buf,count)`, std/io/file_descriptor.mojo) — rostrt implements it
  on OS_WriteC, plus fdopen/dup/fclose/fflush stubs, memcpy,
  KGEN_CompilerRT_{AlignedAlloc,AlignedFree,fprintf}, SWP/LDREX atomics
  (`__atomic_fetch_{add,sub}_4`, `__sync_synchronize`).
- **crt0 now establishes the stack** (`OS_GetEnv` -> `mov sp, r1`): RISC OS
  gives Absolute/AIF images no stack — found live by the emulator side's
  GDB stub (data abort, r13 = &80000000).
- Demo `riscos-test/natural.mojo` -> `natural,ff8` (40,956 bytes, StrongARM).

## Wimp layer (2026-09-09)

- `riscos/appendix_wimp.mojo`: TaskHandle/WindowHandle newtypes, PollBlock
  (stack_allocation-backed), all 19 poll event-code constants, and typed
  bindings for initialise/poll/report_error/create_window/open_window/
  close_down via rostrt's hand shims (`rostrt/wimp.c`, explicit register
  bindings + inline `swi`, numbers from the SWI DB).
- Demo `riscos-test/wimp_hello.mojo`: a real Wimp task — Wimp_Initialise,
  Wimp_ReportError dialog, Wimp_CloseDown, with `print()` on the side.
  Built StrongARM (`wimphello,ff8`) and A72 (`wimphello_a72,ff8`).
- Still open: full-window demo (indirected window template), generated C
  shims for ALL multi-out SWIs (generator extension), R2 driver integration.

## Full-window demo (2026-09-09)

`riscos-test/wimp_window.mojo` — a complete Wimp application in idiomatic
Mojo: `wimp.simple_window(title, message)` builds a PRM-3-87 indirected
template (new-style flags: title bar + close + back icons, Wimp-redrawn
work area, indirected title and text icon in arena-lifetime memory via
`rostrt_alloc`), then a natural poll loop:

    var block = wimp.PollBlock()
    while running:
        let event = wimp.poll(0, block)
        if event == wimp.OPEN_WINDOW_REQUEST:
            wimp.open_window_from_poll(block)
        elif event == wimp.CLOSE_WINDOW_REQUEST:
            running = False

Shim naming unified: every binding (generated or hand) resolves to a C
symbol named exactly like its SWI (`Wimp_Initialise`, `Wimp_Poll`, ...),
so rostrt shims and generated bindings share one contract.
Built: `wimpwindow,ff8` (SA) and `wimpwindow_a72,ff8` (37KB each) —
ready to run when the emulator/debugger lands.

## Shim generator complete (2026-09-09)

`compiler/tools/gen_riscos_pkg.py` now emits BOTH sides from the PRM
database: Mojo bindings (riscos/<chunk>.mojo) AND C shims
(rostrt/swis_<chunk>.c), one function per SWI named exactly like the SWI.
Register model: <=4 entry regs -> args (pointers/blocks -> void*), first
real exit reg (pref R0) -> return value (in/out value regs become read-
modify "+r"), further exit regs -> trailing int* out-params; buffer
registers used in+out stay plain args. Skips: reason-multiplexed SWIs
(OS_Byte/Word/File family), >R3 contracts, and the two 'TASK'-magic
hand shims kept in rostrt/wimp.c.
Coverage: OS 77 + Wimp 49 = 126 SWIs fully bound, zero errors/warnings.
All three demos (natural / wimp_hello / wimp_window) recompile and
relink against the all-generated runtime, entry &8080.

## Whole-OS generation (2026-09-11)

The generator was only ever run for two chunks, so it bound 126 SWIs and
everything else had no binding at all - which means an escape hatch, which
means user code issuing SWIs, which is the one thing the objective forbids.

Run across every prefix in the database: **45 modules, 452 bindings**, a C
shim per SWI beside each, `__init__.mojo` rebuilt from what is actually on
disk. Four chunks (Free, ScreenModes, Squash, TaskWindow) had nothing
bindable and no longer produce a module you have to open before finding out
it is empty.

    CHUNKS=$(sqlite3 ../db/riscos_prm.sqlite       "select group_concat(distinct substr(name,1,instr(name,'_')-1))
       from swi where documented=1 and number is not null")
    python ../compiler/tools/gen_riscos_pkg.py --chunks "$CHUNKS"

`riscos/` is generated output and has never been tracked here; the database
and `compiler/tools/gen_riscos_pkg.py` are the source of truth, both tracked
in the parent workspace. Worth a decision either way - a clone of this fork
alone cannot currently rebuild the package.

### What is still unbound, and why

`compiler/tools/swi_coverage.py` applies the generator's own rules to the
whole database - importing them rather than restating them, so the two
cannot disagree - and reports:

| | count | |
|---|---:|---|
| bindable today | 438 | of 584 documented SWIs |
| reason-multiplexed | 51 | OS_Byte/Word/File/SpriteOp family: one number, many calls, reason codes documented in prose |
| registers above R3 | 93 | a limit of the current shim writer, not of the SWI |
| index-only rows | 200 | a number and nothing else; no register contract to generate from |

The 93 are the cheapest win: ARM passes SWI arguments in R0-R9 and the shim
writer stops at R3 for no reason beyond what was needed at the time.

The 51 are the valuable ones - OS_File, OS_SpriteOp and friends are what
programs actually call - and each is really many functions behind one
number. They need the reason codes lifted out of `use_text` prose, or hand
binding.

## Gates

- **R1 — ARM backend alive**: `BACKENDS += "ARM"`; build `mojo`; verify
  `mojo build --emit asm --target-triple armv8a-none-eabi --target-cpu
  cortex-a72` emits AArch32 from a `.mojo` file directly (no external bridge).
- **R2 — RISC OS target known to the driver**: normalise an
  `armv8a-unknown-riscos` triple in Configuration (no sysroot, no -lm,
  linker = roscc, crt0 = ours); `mojo build` produces objects; roscc links
  a runnable `Absolute,ff8`.
- **R3 — stdlib sys on SWIs**: argv from `OS_GetEnv`, globals via
  `GetOrCreateGlobal` on a static arena / `OS_Heap`, `OS_Exit` on exit;
  soft-float ABI; KGEN_CompilerRT surface implemented in `rostrt`.
- **R4 — teach the elaborator the Wimp**: `mojo/stdlib/std/riscos/` package:
  OS/Wimp/Filing-system APIs as Mojo `extern` decls + typed wrappers,
  **generated from riscos_prm.sqlite**, plus hand-written idioms (Wimp poll
  loop, window templates, task windows). Compile-time safety from the DB's
  register contracts.
- **R5 — proof app**: a Wimp "hello window" written in Mojo, built by
  `mojo build --target riscos`, linked by roscc, running in the RPCEmu
  sandbox and on the Pi 4.

## Non-goals (for now)

MAX (Modular Community Licence — out, as WINMOJO scoped), GPU backends,
64-bit AArch64 RISC OS. Licensing posture mirrors WINMOJO's: Apache-2.0
compiler+stdlib only.
