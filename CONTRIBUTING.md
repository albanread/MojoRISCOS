# Contributing to mojo-riscos

This is an **unaffiliated fork**. It is not Modular's repository, Modular does
not maintain it, and nobody here speaks for them.

## Read this first, because it decides where your change goes

If your change is about **Mojo the language, the standard library, MAX, or
anything that is not RISC OS**, it belongs upstream at
[modular/modular](https://github.com/modular/modular), not here. Send it there.
It will reach the people who maintain that code, it will be reviewed by them,
and everyone downstream — including this fork — gets it. Filing it here helps
nobody: I cannot merge into their tree, and a fix that lives only in a fork is
a fix most users will never see.

If your change is about **making Mojo target RISC OS** — the RISC OS target in
the driver, AArch32 codegen for that target, `sys` and platform layers over
SWIs, the generated Wimp and OS APIs, the RISC OS test programs, the port
documentation — it belongs here.

The rough test: would this change make sense to somebody who has never heard of
RISC OS? If yes, it goes upstream.

## Where to report a bug

- Mojo compiles your code wrongly, the stdlib is broken, MAX misbehaves —
  upstream. Reproduce it against a stock Mojo build first; if it only breaks
  here, it is probably mine.
- The RISC OS target emits bad code, a SWI binding is wrong, the port does not
  build — [here](https://github.com/albanread/MojoRISCOS/issues).

Please say which you have established, and how.

## Licence of contributions

This fork inherits **Apache 2.0 with LLVM Exceptions** from upstream, and
everything added here carries the same terms. By contributing you agree your
changes ship under that licence.

There is no CLA. Upstream has one and it is theirs; it has no application to
this fork, and the workflow that enforced it has been removed precisely so
nobody is asked to sign Modular's agreement to contribute to somebody else's
project.

If your change is one that should go upstream, upstream's CLA is a reason to
send it there directly rather than through me.

## Keeping the fork honest

Two rules exist because a fork that ignores them becomes a liability:

1. **Attribution stays.** `LICENSE`, `Licenses/`, `Licenses/Third-Party-Notices`
   and the per-file `Copyright (c) Modular Inc.` headers are not decoration —
   Apache 2.0 sections 4(a) and 4(c) require them, and almost every file here is
   still Modular's code. Never strip a copyright header from a file you edit.
   [NOTICE](NOTICE) records what changed; add to it if you change an area it
   does not mention.

2. **No Modular binaries.** Nothing here may be built with, extracted from, or
   derived from Modular's packaged SDK, wheels or an account: those are covered
   by the Modular Community License in `Licenses/LICENSE`, which forbids
   redistribution and reverse engineering. Everything in this tree is built from
   published Apache-licensed source, and device runtimes are implemented against
   published ABI declarations. Keep it that way, or the licence this fork
   operates under stops being the one in `LICENSE`.

## Practical notes

- Upstream base is commit `f66d4d52`; `git diff f66d4d52..HEAD` is the honest
  statement of what this fork changed.
- Keep changes to upstream files minimal and obvious. New RISC OS work belongs
  in `riscos/`, `riscos-test/` and the target-specific paths, where it is easy
  to see and easy to rebase.
- Rebasing onto a newer upstream is expected to hurt in `KGEN/` and `bazel/`.
  Small, well-separated diffs are what make it survivable.

## Trademarks

Mojo, MAX and Modular are Modular's marks. Apache 2.0 grants no trademark
rights and this fork is not published under those marks. Do not name a build
from this tree in a way that suggests it is Modular's.
