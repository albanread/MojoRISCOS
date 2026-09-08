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
