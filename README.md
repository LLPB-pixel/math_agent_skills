# MathAgent Skills

Reusable instructions and local tooling for a mathematically rigorous AI
assistant. The repository separates **exploration**, **formal verification**,
**visualization**, **optimization**, **stochastic modelling**, and **final
typesetting** instead of treating every computation as a proof.

> **Core principle — Iterate to solve.** These skills are designed for an agent
> that **iterates**: it formulates a hypothesis, computes, verifies with the
> appropriate tool, inspects errors, corrects, and re-executes until it
> converges to a correct result. A single-shot answer is not expected.

## Design principles

The agent must keep these levels of evidence separate:

1. **Lean / Mathlib** — machine-checked formal proof.
2. **SymPy** — exact symbolic manipulation, subject to its assumptions and
   simplifier.
3. **mpmath / high precision** — numerical evidence with controlled precision.
4. **NumPy / SciPy** — floating-point numerical computation.
5. **Plots and animations** — visual intuition, never a proof.

The skills also require explicit domains, assumptions, tolerances, random
seeds, solver statuses, compilation checks, and honest reporting of failures.

**6. Mandatory iteration — Iterative problem solving.** No result is accepted on
the first attempt. Each skill defines its own verify-and-correct loop and the
global orchestrator is cyclic, not linear. A compilation failure, a `sorry` in
Lean, a non-zero residual in SymPy, a `status != OPTIMAL` in optimization, or a
`pdflatex` error requires diagnosis, reformulation, and re-execution.

## Skills

| Skill | Main use | Typical output |
| --- | --- | --- |
| [`python-scientific`](python-scientific/SKILL.md) | Symbolic and numerical calculation | Exact expressions, numerical checks, plots |
| [`lean`](lean/SKILL.md) | Formal theorem verification | Compiling `.lean` proofs |
| [`latex`](latex/SKILL.md) | Mathematical documents | Reproducible `.tex`, PDF, and previews |
| [`jupyter-visualization`](jupyter-visualization/SKILL.md) | Reproducible experiments | Executed notebooks and figures |
| [`manim-animation`](manim-animation/SKILL.md) | Explanatory mathematics animations | Rendered videos or frames |
| [`optimization-or`](optimization-or/SKILL.md) | LP, MILP, convex and nonlinear optimization | Validated candidate solutions and sensitivity data |
| [`statistics-stochastics`](statistics-stochastics/SKILL.md) | Probability, simulation, and inference | Estimates with uncertainty and diagnostics |

## Iterative workflow — The agent must iterate

**These skills require the agent to iterate to solve mathematical problems.**
Chaining `explore → verify → typeset` once is not enough. Every stage must run
as a **hypothesis → computation → inspection → correction → re-verification**
loop until the evidence reaches the level demanded by the rigor hierarchy.

### Global cyclic flow (not linear)

`AGENTS.md` defines a multi-skill flow that is explicitly iterative:

```text
                    ┌──────────────────────────────────────────────────┐
                    │                                                  │
                    ▼                                                  │
 hypothesis / mathematical idea                                        │
        │                                                              │
        ├─► explore & compute  (python-scientific / jupyter) ──────────┤
        │         │  ▲                                                 │
        │         │  └──── inspect, compare, refine ───────────────────┤
        │         ▼                                                    │
        ├─► formalize & verify (lean) ─────────────────────────────────┤
        │         │  ▲                                                 │
        │         │  └──── lean error / sorry → fix → lake build ──────┤
        │         ▼                                                    │
        ├─► model & optimize / simulate (optimization-or /             │
        │      statistics-stochastics) ──► status/feasibility check ───┤
        │         │  ▲                                                 │
        │         │  └──── infeasible / non-optimal → reformulate ─────┤
        │         ▼                                                    │
        └─► typeset & visualize (latex / manim) ───────────────────────┤
                  │  ▲                                                 │
                  │  └──── pdflatex error / overfull box / preview ────┤
                  ▼                                                    │
              deliver with labels: exact / numerical approximation /   │
                    empirical observation / formally verified in Lean ──┘
```

> Use only the stages the problem actually requires, but **iterate inside each
> stage** until it compiles, verifies, or converges. An unverified result is
> never presented as proven.

### Iteration loops by skill

Each skill documents its own internal cycle that the agent must follow:

* **`python-scientific`** — symbolic derivation with SymPy → `simplify(lhs-rhs)==0` → if it does not simplify to zero, do not assume truth; 50 dps numerical check with `verify_identity.py` at deterministic points → if a residual remains, review domain, assumptions, and branches → reformulate and re-execute. Always distinguish exact from floating-point approximation.

* **`jupyter-visualization`** — `hypothesis → build experiment → execute → inspect output → visualize → compare with expected → modify experiment` (SKILL.md § General workflow). Save the notebook executed top-to-bottom with no hidden state and with fixed seeds.

* **`lean`** — `idea → formalize proposition → write proof → lake build / lake env lean → inspect error → fix → recompile` until success without `sorry`/`admit`. A file that compiles with `sorry` is a draft, not a verified proof.

* **`optimization-or`** — model (objective, variables, bounds, duals) → solve → check `status == OPTIMAL / success==True` → verify constraint residuals and recompute objective → if `INFEASIBLE`/`UNBOUNDED`/`OPTIMAL_INACCURATE`, diagnose scaling, convexity, and tolerances → reformulate.

* **`statistics-stochastics`** — define probabilistic model → simulate with explicit seed → estimate with standard error / CI → compare empirical vs. theoretical → if autocorrelation or lack of convergence, adjust `N`, burn-in, thinning, MCMC diagnostics → re-simulate.

* **`latex`** — create `.tex` → `pdflatex -halt-on-error` (two passes) → `compile_and_preview.sh` → inspect PNGs, `overfull boxes`, undefined references, missing figures → fix typography/layout → recompile. Never claim a PDF is complete if it has not compiled cleanly.

* **`manim-animation`** — sketch scene → `manim -ql` (low resolution) → inspect frame/video → adjust `MathTex`/`Axes` → `manim -qh` final render. Animations illustrate; they do not prove.

### What "iterate" means in practice

1. **Execute the real tool** — do not simulate output. Before using it, check that it is available (`lake`, `python3`, `pdflatex`, `manim`, `kpsewhich`).
2. **Read the diagnostic** — Lean log, SymPy traceback, `prob.status`, `res.success`, LaTeX log.
3. **Fix the mathematical or technical cause** — do not hide the error by inventing a result.
4. **Re-execute and record which evidence layer was achieved** — `exact`, `numerical approximation`, `empirical observation`, `formally verified in Lean`.
5. **Honestly report unresolved failures** — missing dependency, inconclusive simplification, remaining `sorry`.

This iterative behavior is what distinguishes these skills from single-shot use:
the agent explores, computes, formally verifies when appropriate, and presents,
refining on each pass until the mathematics is rigorous and the document
compiles.

## Repository layout

```text
.
├── AGENTS.md                         # Global orchestration and rigor rules
├── .agents/AGENTS.md                 # Compatible agent-specific copy
├── python-scientific/                # SymPy/NumPy/SciPy helper and tests
├── lean/                             # Lean guidance and examples
│   └── formal_proofs/                 # Larger experimental proof collection
├── latex/                            # LaTeX guidance, template, and compiler
├── jupyter-visualization/            # Notebook workflow
├── manim-animation/                  # Manim workflow
├── optimization-or/                  # Operations-research workflow
├── statistics-stochastics/           # Probability and statistics workflow
├── tests/                            # Mathematical problem catalogue
└── results/                          # Reproducible TeX write-ups and PDFs
```

Build caches and LaTeX auxiliary files are intentionally excluded by
[`.gitignore`](.gitignore). Generated PDFs may be kept when they are useful as
release artifacts; source files remain the reproducible source of truth.

## Quick checks

Run these from the repository root when the corresponding tools are available:

```bash
# Root Lean project
lake build

# Python helper tests (standard unittest runner)
python3 -m unittest discover -s python-scientific/tests -p 'test_*.py'

# Symbolic and high-precision identity check
python3 python-scientific/scripts/verify_identity.py \
  "sin(2*x)" "2*sin(x)*cos(x)"

# Compile and preview the LaTeX template
./latex/scripts/compile_and_preview.sh latex/templates/article_template.tex
```

The optional `lean/formal_proofs` collection has its own Lean toolchain and
Mathlib dependency:

```bash
lake build
```

Run that command **inside** `lean/formal_proofs`. It contains both completed
examples and work-in-progress files; a successful build of the root project
does not certify the entire collection. Any file containing `sorry` or
`admit` is an incomplete draft by design.

## Environment

The skills use locally installed tools when present: Lean/Lake, Python with
SymPy, NumPy, SciPy and Matplotlib, a LaTeX distribution, Jupyter, Manim,
CVXPY/PuLP, and PyMC. Optional tools are not silently substituted. Check
availability first and report a missing capability instead of installing a
dependency or inventing an output.

## Contributing

When adding or changing a skill:

1. Keep the frontmatter `name` and `description` accurate.
2. State when the skill should and should not be used.
3. Include a minimal runnable example when possible.
4. Distinguish exact, numerical, empirical, and formally verified results.
5. Test scripts and compile generated documents before claiming success.
6. Do not commit build caches, credentials, or generated auxiliary files.

The global rules in [`AGENTS.md`](AGENTS.md) apply to every skill.
