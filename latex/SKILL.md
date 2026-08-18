---
name: latex
description: Use LaTeX to produce clear, well-formatted mathematical documents, reports, solutions, notes, and figures. Use images and diagrams when they materially improve mathematical clarity.
---

# LaTeX

## Purpose

Use LaTeX to produce high-quality mathematical documents.

The primary goals are:

- mathematically correct notation;
- clear structure;
- readable equations;
- consistent formatting;
- useful figures and diagrams;
- reproducible source files;
- professional presentation.

LaTeX should be used for final mathematical write-ups rather than as a scratchpad for calculations.

## General principles

1. Prefer clear mathematical notation over unnecessary formatting.
2. Keep the document structure logical and consistent.
3. Use displayed equations for important derivations.
4. Do not put long mathematical derivations into dense paragraphs when separate equations improve readability.
5. Define notation before using it when it is not standard.
6. Keep explanations close to the equations they explain.
7. Avoid decorative formatting that does not improve comprehension.
8. Never invent mathematical results, references, figures, or numerical values.
9. Preserve the distinction between exact mathematical results and numerical approximations.
10. Compile the document before considering the LaTeX output complete.

## System Environment & Available LaTeX Packages

Do not assume that `texlive-full` or any other package bundle is installed.
The configured `pdflatex` may come from a minimal TinyTeX installation, and
optional packages can be absent. Check the actual environment before choosing
packages.

The current template has been kept to a small core that is available here:
`amsmath`, `amssymb`, `amsthm`, `graphicx`, `float`, `booktabs`, `geometry`,
and `hyperref`. Packages such as `mathtools`, `tikz-cd`, `siunitx`, `tikz`,
`pgfplots`, and `microtype` are optional and must be checked individually.

### Verification Command
To check if any specific package is available in the system TeX tree:
```bash
/usr/bin/kpsewhich package_name.sty
```

The repository helper performs two `pdflatex` passes with
`-halt-on-error` and then creates PNG page previews:

```bash
./latex/scripts/compile_and_preview.sh path/to/document.tex
```

It is a compilation/layout check, not a mathematical proof. Inspect the log
for undefined references, overfull boxes, missing figures, and bibliography
warnings after the command succeeds.

## Recommended document structure

For a mathematical assignment or report, prefer:

```latex
\documentclass[11pt,a4paper]{article}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath,amssymb,amsthm}
\usepackage{graphicx}
\usepackage{float}
\usepackage{booktabs}
\usepackage{geometry}
\usepackage{hyperref}

\geometry{margin=2.5cm}

\begin{document}

\title{...}
\author{...}
\date{\today}

\maketitle

\section{...}

...

\end{document}
```

Use `amsmath`, `amssymb`, and `amsthm` for the portable mathematical core.
Use `mathtools` only after verifying that it is installed.

Use `graphicx` for images.

Use `geometry` for sensible page margins.

Use `hyperref` for internal and external links when appropriate.

## Mathematical notation

Use LaTeX commands rather than Unicode mathematical symbols inside equations.

Prefer:

```latex
\[
\int_0^1 x^2\,dx = \frac{1}{3}.
\]
```

rather than inserting Unicode mathematical symbols manually.

Use:

- `\frac{a}{b}` for fractions;
- `\sqrt{x}` for square roots;
- `\sum`, `\prod`, `\int` for operators;
- `\partial` for partial derivatives;
- `\nabla` for gradients;
- `\mathbb{R}`, `\mathbb{N}`, `\mathbb{Z}` for standard number sets;
- `\mathbf{x}` or `\boldsymbol{x}` when vector notation is required;
- `\left(` and `\right)` when scalable delimiters improve readability.

Use `\,` for small mathematical spacing when appropriate.

## Displayed equations

Use `equation` for a single numbered equation:

```latex
\begin{equation}
f'(x) = 2x.
\end{equation}
```

Use `align` for multi-step derivations:

```latex
\begin{align}
f(x)
  &= x^2 + 2x + 1 \\
  &= (x+1)^2.
\end{align}
```

Do not number every trivial equation.

Use unnumbered display math:

```latex
\[
...
\]
```

when a reference number is unnecessary.

## Derivations

When solving a mathematical problem, make the logical sequence explicit.

Prefer:

```latex
\begin{align}
y' + 2y &= e^x, \\
y' + 2y &= e^x, \\
\frac{d}{dx}\left(e^{2x}y\right) &= e^{3x}.
\end{align}
```

Then explain the relevant transformation in prose.

Do not produce unexplained walls of equations.

## Theorems, definitions, and proofs

When writing mathematical documents containing formal results, use theorem environments.

Example:

```latex
\newtheorem{theorem}{Theorem}
\newtheorem{proposition}{Proposition}
\newtheorem{lemma}{Lemma}
\theoremstyle{definition}
\newtheorem{definition}{Definition}
```

Then:

```latex
\begin{theorem}
Let ...
\end{theorem}

\begin{proof}
...
\end{proof}
```

Use definitions for terminology and theorems/propositions for mathematical claims that will be referenced later.

## Matrices

Use appropriate matrix environments:

```latex
\[
A =
\begin{pmatrix}
1 & 2 \\
3 & 4
\end{pmatrix}.
\]
```

Use `bmatrix`, `pmatrix`, `vmatrix`, etc. according to the mathematical meaning.

## Cases and piecewise functions

Use:

```latex
\[
f(x) =
\begin{cases}
x^2, & x \geq 0, \\
-x, & x < 0.
\end{cases}
\]
```

Keep conditions aligned and readable.

## Tables

Use `booktabs` rather than manually drawing many horizontal lines.

Example:

```latex
\begin{table}[ht]
\centering
\begin{tabular}{lcc}
\toprule
Method & Error & Time \\
\midrule
Method A & $10^{-4}$ & 0.12 s \\
Method B & $10^{-7}$ & 0.31 s \\
\bottomrule
\end{tabular}
\caption{Comparison of numerical methods.}
\label{tab:comparison}
\end{table}
```

Refer to tables using `\ref{tab:comparison}` instead of phrases such as "the table above".

## Figures and images

Include images when they provide genuine mathematical or explanatory value.

Useful cases include:

- graphs of functions;
- numerical solutions;
- convergence plots;
- geometric constructions;
- diagrams of mathematical objects;
- flow diagrams;
- illustrations of algorithms;
- visual comparisons of numerical methods.

Do not add images merely to make a document look more decorative.

For an existing image:

```latex
\begin{figure}[ht]
\centering
\includegraphics[width=0.75\textwidth]{figures/example.png}
\caption{Example of the numerical solution.}
\label{fig:solution}
\end{figure}
```

Prefer relative paths such as:

```text
figures/example.png
```

rather than absolute filesystem paths.

Always give figures meaningful captions and labels when they are referenced in the text.

Refer to them using:

```latex
Figure~\ref{fig:solution}
```

rather than "the image above".

## Generating mathematical figures

When a figure should be generated from mathematical data, prefer reproducible generation.

For plots, generate the image with Python/Matplotlib and include the resulting file in LaTeX.

For diagrams that are naturally expressed in LaTeX, consider TikZ/PGFPlots when appropriate.

Do not manually draw a graph if the underlying mathematical data can be generated reproducibly.

## TikZ and Commutative Diagrams

Use TikZ for diagrams when the figure is primarily structural or geometric.

Example:

```latex
\begin{tikzpicture}
  \draw[->] (0,0) -- (3,0) node[right] {$x$};
  \draw[->] (0,0) -- (0,3) node[above] {$y$};
\end{tikzpicture}
```

For commutative diagrams in abstract algebra, topology, and category theory, use `tikz-cd`:

```latex
\usepackage{tikz-cd}

\begin{tikzcd}
A \arrow[r, "f"] \arrow[d, "\pi"'] & B \arrow[d, "\eta"] \\
A/K \arrow[r, "\bar{f}"'] & C
\end{tikzcd}
```

Do not use TikZ for large numerical datasets or complicated scientific plots when Python/Matplotlib is more appropriate.

## PGFPlots

Use PGFPlots when reproducible plots directly inside LaTeX are useful.

For large or computationally generated datasets, prefer generating the plot externally with Python and including the resulting image.

## Image quality

Use sufficiently high resolution for raster images.

Prefer vector formats such as PDF or SVG-compatible workflows for diagrams when the toolchain supports them.

Avoid:

- stretched images;
- tiny unreadable labels;
- excessive whitespace;
- low-resolution screenshots;
- screenshots of code when actual LaTeX text would be clearer.

Crop images when necessary.

Keep figure widths proportional to the page.

## Captions

Captions should explain what the figure or table represents.

Bad:

```latex
\caption{Graph}
```

Better:

```latex
\caption{Numerical approximation of the solution of the initial-value problem for several step sizes.}
```

## References

Use labels and references consistently:

```latex
\label{eq:important}
```

and:

```latex
Equation~\eqref{eq:important}
```

For figures:

```latex
Figure~\ref{fig:example}
```

For tables:

```latex
Table~\ref{tab:results}
```

Do not hard-code equation, figure, or table numbers.

## Units

For documents containing substantial physical or numerical quantities, use `siunitx` when available.

Example:

```latex
\usepackage{siunitx}

The measured value is
\[
v = \SI{3.2}{\meter\per\second}.
\]
```

Do not mix units inconsistently.

## Code listings

If source code needs to be included, use a suitable code-listing package such as `listings` or `minted`.

Do not put large amounts of code into the main mathematical exposition unless the code itself is the subject.

## Citations and bibliography

If sources are used, cite them consistently.

For larger documents, prefer BibTeX or BibLaTeX rather than manually formatting a long bibliography.

Never fabricate citations.

## Compilation & Visual Inspection

Always compile the LaTeX document after creating or modifying it using `pdflatex`, `xelatex`, or `lualatex`.

### Visual Inspection Workflow
To visually inspect the layout, typography, and mathematical formatting:
1. Compile the `.tex` document to `.pdf`.
2. Convert PDF pages to PNG images using `pdftoppm -png -r 150 document.pdf page`.
3. Inspect the generated images to verify page breaks, equation formatting, and figure placement.

Alternatively, execute the provided helper script:
```bash
./scripts/compile_and_preview.sh main.tex
```

Check for:

- compilation errors;
- undefined references;
- missing images;
- overfull boxes;
- broken equations;
- incorrect figure placement;
- unreadable tables;
- missing bibliography entries.

If compilation fails or layout issues are detected, fix the error before presenting the document as finished.

## File organization

Prefer:

```text
project/
├── main.tex
├── figures/
│   ├── plot1.pdf
│   └── diagram.png
├── sections/
│   ├── introduction.tex
│   └── results.tex
└── references.bib
```

For small documents, a single `main.tex` file is acceptable.

Keep generated files separate from source files when practical.

## Interaction with mathematical tools

LaTeX is a presentation layer, not the primary calculation engine.

Use:

- SymPy for symbolic calculations;
- NumPy/SciPy for numerical calculations;
- Lean for formal mathematical verification;
- Matplotlib for numerical plots.

Then use LaTeX to present the verified results clearly.

Do not manually transcribe large numerical datasets if they can be generated automatically.

## Agent workflow

When asked to produce a mathematical document:

1. Understand the mathematical task.
2. Solve or verify calculations using appropriate computational tools.
3. Determine which results require formal verification.
4. Generate figures only when they add meaningful information.
5. Create the LaTeX source.
6. Compile it.
7. Inspect the resulting document.
8. Fix formatting or mathematical issues.
9. Compile again.
10. Deliver the final source and generated artifacts.

Never claim that a PDF or LaTeX document is complete without checking compilation.

## Quality checklist

Before finalizing:

- [ ] Mathematical notation is consistent.
- [ ] Important equations are clearly displayed.
- [ ] Derivations are logically ordered.
- [ ] Definitions and assumptions are explicit.
- [ ] Figures are included only when useful.
- [ ] Figures have captions and labels where appropriate.
- [ ] Tables are readable.
- [ ] Cross-references work.
- [ ] Images are not stretched or blurry.
- [ ] No unnecessary decorative elements were added.
- [ ] Exact and numerical results are clearly distinguished.
- [ ] The document compiles without errors.
- [ ] There are no unresolved references.
