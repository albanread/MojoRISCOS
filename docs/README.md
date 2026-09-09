# Documentation

Modular's documentation was removed from this fork. It described their
platform, their release process and their product surface, none of which this
tree is any longer a fair description of, and keeping it would have meant
shipping their docsite content under a repository that is not theirs.

For Mojo the language, the standard library or MAX, go to the source:
[docs.modular.com](https://docs.modular.com) and
[modular/modular](https://github.com/modular/modular). Those are current,
maintained, and written by the people responsible for them. Nothing here
supersedes them.

What follows is this fork's own, written against a different platform.

## The port

The primary document is [RISCOS-PORT.md](../RISCOS-PORT.md) at the root —
dated entries, the target matrix, gate status and the reasoning behind each
decision. [README.md](../README.md) is the summary; the journal is the detail.

- [DIALECT-NOTES.md](DIALECT-NOTES.md) — where this fork's Mojo differs from
  what the manual describes
- [LANGUAGE-DRIFT.md](LANGUAGE-DRIFT.md) — upstream language changes and what
  they cost to track
- [mojo-traps.md](mojo-traps.md) — behaviour that surprises, and why

## Compiler and runtime

- [addresses-and-optimization.md](addresses-and-optimization.md)
- [event-loop.md](event-loop.md)
- [latency.md](latency.md)
- [occlusion.md](occlusion.md)
- [debugger-conditions.md](debugger-conditions.md)

## Tooling and host

- [lsp-windows.md](lsp-windows.md)
- [win32_posix_shim.md](win32_posix_shim.md)
- [tsf-manual-check.md](tsf-manual-check.md)
- [STDLIB-TEST-BASELINE.md](STDLIB-TEST-BASELINE.md) — what passes, and what
  was already failing before this fork touched it
- [TEST-SUITE-DESIGN.md](TEST-SUITE-DESIGN.md)
- [SNAPDRAGON-GPU.md](SNAPDRAGON-GPU.md)

## Writing new docs here

Two things worth keeping to, since the tree no longer has upstream's
conventions to fall back on:

1. **Say what was established and when.** The port journal works because each
   entry is dated and states what was verified rather than what was intended.
   A document that records a decision without its reasoning is a document
   somebody will reverse by accident.

2. **Do not re-document Mojo.** If a page would make sense to somebody who has
   never heard of RISC OS, it belongs upstream or nowhere. This directory is
   for what is true *here* — the RISC OS target, the two ARM profiles, the SWI
   bindings, the host port, and the places where this fork and upstream have
   drifted apart.
