# Experimental formal proofs

This directory contains Lean/Mathlib formalizations and proof sketches
associated with the problem catalogue in [`../../tests/tests_100.md`](../../tests/tests_100.md).
It is intentionally separate from the small root Lake project because it uses
its own Lean toolchain and dependency declaration.

## Status convention

- A file that compiles **without** `sorry`, `admit`, or equivalent placeholders
  is a formally checked proof in the configured environment.
- A file that compiles with a placeholder is a checked draft, not a completed
  theorem.
- A failed build is reported as failed; cached `.olean` files do not change
  that status.

The collection is work in progress. Do not describe the whole directory as
formally verified merely because some individual files compile.

## Checking the collection

Run the commands from this directory:

```bash
lake build
lake env lean Problem01.lean
```

The first command checks the targets listed in `lakefile.lean`; the second is
useful for a single file when its imports are available. The repository does
not commit `.lake` build caches. If Mathlib is unavailable in the local
environment, report that capability failure instead of fabricating a result.

Before reporting a proof as complete, inspect compiler output for errors and
placeholder warnings, and check the source for `sorry` or `admit`.
