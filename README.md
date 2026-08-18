# MathAgent Skills

Reusable instructions and local tooling for a mathematically rigorous AI
assistant. The repository separates **exploration**, **formal verification**,
**visualization**, **optimization**, **stochastic modelling**, and **final
typesetting** instead of treating every computation as a proof.

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

For multi-step problems, the recommended workflow is:

```text
explore and compute  →  formalize and verify  →  typeset or visualize
```

Use only the stages that the problem actually requires.

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
