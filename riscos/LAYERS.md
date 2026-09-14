# The layers, and the portability rule

Mojo code on RISC OS is written against three layers.  Which layer a
program touches decides what survives a RISC OS version change.

```
    ┌─────────────────────────────────────────────────────┐
    │  application code (demos, apps)                     │
    ├──────────────────────────────┬──────────────────────┤
    │  riscos.clib                 │  riscos.wimp etc.    │
    │  the C library surface       │  idiomatic wrappers  │
    │  (generated from clib.json)  │  (appendix_*.mojo)   │
    ├──────────────────────────────┴──────────────────────┤
    │  generated SWI modules + rostrt/roclib runtime      │
    │  (rebuilt per RISC OS version — never imported)     │
    └─────────────────────────────────────────────────────┘
```

**The rule**: application code imports `riscos.clib` and the appendix
modules — never the raw generated SWI modules (`riscos.os`,
`riscos.wimp`, ...) and never a SWI name.

* `riscos.clib` is the portable surface — memory (`malloc`/`free`),
  strings, stdio, files, time — calling the ROM's SharedCLibrary
  through the roclib veneers.  A future RISC OS rebuilds the veneers
  (a table in ROSCC, regenerated from the binding spec) and every
  program keeps running unchanged.

* The Wimp has no C API — its SWIs *are* its public interface, the
  platform equivalent of syscalls.  Portability there comes from the
  appendix layer's types and shapes (`TaskHandle`, `PollBlock`,
  `simple_window`), which isolate that interface the way a toolkit
  isolates the window system on any OS.  If a future RISC OS grows a
  C surface for it, the appendix's implementation swaps; apps do not.

* The generated SWI modules and rostrt/roclib are build-time
  implementation.  Nothing outside them names a SWI.

## Entering through the C library

A program whose `main(argc, argv)` should run under the library (heap,
stdio, library-owned exit) links `crt0clib-$TAG.o` instead of
`crt0-$TAG.o`; roclib_run then drives registration, `_kernel_init`,
`_main` and the callback into `main`.  Proven end to end by ROSCC's
`test/mojopath2.ll` — a whole program in the compiler's emitted shape,
malloc and all, green on the emulator farm.

The current entry (`crt0`, plain) suits programs that want only the
pure surface or rostrt's own arena — registration still happens if the
roclib objects are linked, but the stateful half (heap/stdio) requires
the clib entry.
