---
name: lean
description: Use Lean and Mathlib to formally verify mathematical statements and proofs. Treat Lean as the authoritative checker for formal proofs.
---

# Lean Formal Verification

## Purpose

Use Lean as a formal proof checker.

Lean is fundamentally different from a symbolic calculator. Its purpose is to establish that a proposition follows from definitions, axioms, and previously established theorems.

A proof that compiles successfully is formally verified within the imported Lean environment.

## Core rule

Never claim that a mathematical proof has been formally verified unless Lean successfully checks the proof.

Workflow:

```text
mathematical idea
      ↓
formalize proposition
      ↓
write Lean proof
      ↓
compile/check
      ↓
success or failure
```

## Environment

Use the project's configured Lean version and Mathlib version.

Do not assume syntax or theorem names from another Lean version are available.

In this repository there are two relevant environments:

- the root Lake project, checked with `lake build`; and
- `lean/formal_proofs`, a larger experimental collection with its own
  `lean-toolchain` and Mathlib dependency.

Run the command from the appropriate directory. A successful root build does
not certify every file under `lean/formal_proofs`, and an experimental file
containing `sorry` must be reported as incomplete.

Before attempting complicated proofs, inspect the project and imported modules.

## Basic workflow

For every proof:

1. Understand the mathematical statement.
2. Identify all assumptions.
3. Translate the statement into Lean.
4. Determine relevant Mathlib lemmas.
5. Construct the proof.
6. Run Lean.
7. Inspect compiler errors.
8. Correct the proof.
9. Run Lean again.
10. Only report success after Lean accepts the final proof.

For a small proof in this repository, the minimum check is:

```bash
lake build
```

For an individual standalone file, use the configured toolchain and make sure
that its imported modules are available, for example:

```bash
lake env lean path/to/file.lean
```

Do not use a cached `.olean` file as evidence that the current source checks;
re-run Lean after changing the source.

## Never fake verification & Handling of `sorry`

Do not claim that Lean confirms a result unless the proof was actually checked by Lean without errors.

A code snippet containing `sorry` or `admit` is a **draft/sketch**, NOT a formally verified proof. Always declare `sorry` explicitly when presenting a partial proof.

If Lean is unavailable or compilation fails, state clearly that formal verification could not be completed.

Warnings also matter: a file that compiles with a declaration using `sorry`,
`admit`, or an equivalent placeholder is a checked *draft*, not a complete
formal proof. Keep a separate status for “parses/compiles” and “proves the
claim without placeholders”.

## Structured Proofs (`calc` blocks)

For step-by-step equality or inequality derivations, prefer human-readable `calc` blocks over long opaque tactic scripts:

```lean
import Mathlib.Data.Real.Basic

example (a b : ℝ) : (a + b)^2 - (a - b)^2 = 4 * a * b := by
  calc
    (a + b)^2 - (a - b)^2 = (a^2 + 2*a*b + b^2) - (a^2 - 2*a*b + b^2) := by ring
    _                    = 4 * a * b                           := by ring
```

## Arithmetic and Specialized Tactics

Common tactics include:

- `norm_num`: Evaluate explicit numerical expressions.
- `ring` / `ring_nf`: Polynomial equality simplification over commutative rings.
- `linarith`: Linear real/rational arithmetic inequalities.
- `nlinarith`: Nonlinear real arithmetic inequalities.
- `positivity`: Automatically prove that an expression is positive, non-negative, or non-zero.
- `gcongr`: Generalized congruence tactic for proving inequalities by matching relational subterms.
- `simp`: Definitional and algebraic simplifier based on rewrite lemmas.

Example using `positivity`:

```lean
import Mathlib.Tactic.Positivity

example (a b : ℝ) (ha : 0 < a) (hb : 0 < b) : 0 < a^2 + b^2 := by
  positivity
```

## Proof search and automation

Useful tactics for finding lemmas:

```lean
exact?
apply?
rw?
simp?
```

When automation finds a proof, inspect what happened when practical. The final proof should remain understandable and maintainable.

## Definitions and assumptions

Pay particular attention to:

- domains;
- positivity assumptions;
- nonzero assumptions;
- continuity;
- differentiability;
- invertibility;
- finite/infinite structures;
- type coercions.

A statement true over `ℝ` may not be true over an arbitrary algebraic structure.

Do not silently weaken or strengthen the original mathematical statement.

## Calculus

Lean can formally reason about limits, continuity, derivatives, integrals, sequences, series, and real analysis.

Formal calculus may require substantially more setup than the corresponding SymPy calculation. Use SymPy for exploration and Lean for formal verification.

Do not expect Lean to behave like a computer algebra system.

## External calculations

If a calculation is performed with Python/SymPy, MATLAB, Mathematica, or another external system, that calculation is NOT automatically formally verified by Lean.

If formal verification is required, translate the relevant mathematical claim into Lean and prove it there.

## Proof development strategy

For difficult proofs:

1. prove small helper lemmas;
2. inspect the exact Lean goal after important steps;
3. search Mathlib for existing theorems;
4. use explicit intermediate facts;
5. only then attempt larger automation.

Avoid enormous opaque proof scripts when smaller lemmas are clearer.

## Final reporting

For every formally verified result, distinguish:

- mathematical intuition;
- computational experimentation;
- formal Lean verification.

Only the third constitutes formal verification.

When reporting a successful proof, provide the Lean source or relevant theorem and state that it successfully checks in the configured environment.
