# Mojo Windows x64 + NVIDIA release

This is a standalone Windows x64 build. Mojo GPU code is compiled to PTX and
loaded through the NVIDIA driver by `nvptxrt`; no CUDA toolkit or Bazel is used
at runtime.

`nvptxrt` is a DLL, linked through the import library `lib\nvptxrt.lib` the
way `KGENCompilerRTShared`, `AsyncRTRuntimeGlobals` and `MSupportGlobals` are.
A program built here carries a few kilobytes of import stubs and loads
`nvptxrt.dll` from `lib` (or `bin`) when it starts, so a fix to the runtime
reaches every program already built against it by replacing one file. The
launchers put `bin` and `lib` on `PATH`; Griddle does the same for anything it
builds and runs.

The GPU target is not fixed at packaging time. The launchers pass the generic
`cuda` selector, which resolves to whichever supported card is installed, so
the same release works on any of them. Pass `--target-accelerator` explicitly
to compile for a different card than the one present.

## Commands

- `mojo.cmd --version` runs the compiler.
- `mojo.cmd run examples\hello.mojo` runs a Mojo source file through the JIT.
- `mojo.cmd build examples\hello.mojo -o hello.exe` builds a Windows x64 EXE.
- `mojo-gpu-run.cmd file.mojo` JIT-runs for the installed GPU.
- `mojo-gpu-build.cmd file.mojo -o file.exe` builds for the installed GPU.
- `mojo.cmd repl` starts the LLDB-backed Mojo REPL.
- `mandelbrot.cmd` runs the prebuilt windowed NVIDIA Mandelbrot example.
- `mojo-shell.cmd` opens a command prompt with the release DLL and MSVC paths.

The compiler finds this package from its own executable, so `bin\mojo.exe`
works from any shell with nothing set. The launchers only add `bin` and `lib`
to `PATH` and find the installed Visual Studio x64 libraries for linking.
Everything the toolchain writes -- its cache and crash reports -- goes to
`%LOCALAPPDATA%\WinMojo`; nothing in this tree is ever modified after it is
unpacked. Executables built against the shared Mojo runtime get the runtime
DLLs copied beside them by the IDE; from the command line, run them from
`mojo-shell.cmd` or with this release's `lib` directory on `PATH`.

The release contains the Mojo compiler, `std` and `max` packages, LLDB and the
Mojo debugger plugin, Crashpad, `lld`, the Windows API database, and the
open-source NVIDIA PTX driver runtime. The proprietary NVIDIA display driver is
still required to execute PTX on the GPU; no proprietary CUDA compiler or CUDA
runtime is bundled.

## Installing

Three ways, least commitment first:

- **The zip alone.** Unpack it anywhere -- a directory, a second drive, a
  memory stick, a read-only location -- and run `bin\griddle.exe`,
  `bin\mojo.exe` or any launcher. Nothing is configured and nothing is
  rewritten; the tree finds itself wherever it is, so moving it later is
  fine too.
- **The installer** (`*-setup-*.exe`). The same tree with the usual
  conveniences: pick a directory (anywhere you can write -- no
  administrator rights, nothing touches system directories), choose
  components (the Python runtime, the examples, the guide), get Start
  Menu shortcuts and an entry in Apps & Features that uninstalls
  cleanly. Built with NSIS by `create-release.ps1 -Installer`.
- **`install.ps1`**, for the versioned layout: it unpacks releases under
  one root with a `current` junction, so several versions sit side by
  side and switching is repointing the junction.

The IDE is `bin\griddle.exe`, directly or via `griddle.cmd`; a pinned
taskbar shortcut to the exe works because nothing needs setting up first. Python comes bundled in `python\`; the
IDE's Python menu and the compiler's interop use it with nothing to
configure. The programmer's guide is in `WinMojoGuide\`.
