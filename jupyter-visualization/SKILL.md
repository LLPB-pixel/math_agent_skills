---
name: jupyter-visualization
description: Use Jupyter notebooks and Matplotlib for mathematical experimentation, numerical inspection, visualization, and reproducible computational experiments.
---

# Jupyter and Visualization

## Purpose

Use Jupyter as an interactive laboratory for mathematical computation.

The notebook is primarily for:

- exploring mathematical ideas;
- running Python calculations;
- visualizing functions;
- comparing analytical and numerical solutions;
- investigating numerical behavior;
- producing reproducible experiments.

The notebook is not itself a proof system.

Use this skill for short, inspectable experiments and visual explanations. For
reusable command-line computations, prefer a `.py` script; for final
mathematical exposition, use the `latex` skill. Do not assume that Jupyter,
Plotly, or an optional kernel is installed: check the environment and report
when execution cannot be performed.

## General workflow

For mathematical experiments:

```text
mathematical hypothesis
        ↓
construct computation
        ↓
run experiment
        ↓
inspect numerical result
        ↓
visualize
        ↓
compare with expected result
        ↓
draw conclusions
```

Keep experiments reproducible.

## Notebook organization

Use separate cells for:

1. imports;
2. definitions;
3. symbolic derivation;
4. numerical computation;
5. verification;
6. visualization;
7. conclusions.

Avoid huge cells containing unrelated calculations.

Start from a clean kernel and run the notebook from top to bottom before
delivering it. Avoid hidden state, manual edits to displayed output, and
dependencies on a local working directory. If execution is available, a
reproducible check can be performed with:

```bash
jupyter nbconvert --to notebook --execute notebook.ipynb \
  --output notebook-executed.ipynb
```

If this command is unavailable or fails, preserve the error and describe the
notebook as unexecuted rather than presenting stale output as a result.

## Visualization

Use Matplotlib for functions, trajectories of ODEs, convergence, numerical error, Fourier series, residuals, optimization trajectories, and probability distributions.

Example:

```python
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(-5, 5, 1000)
y = x**2

plt.figure()
plt.plot(x, y)
plt.xlabel("x")
plt.ylabel("f(x)")
plt.title("f(x) = x²")
plt.grid(True)
plt.show()
```

Plots should help inspect mathematical behavior.

## 3D Visualization and Vector Fields

For multivariable calculus, differential geometry, and vector calculus, use 3D plots (`mpl_toolkits.mplot3d`) or vector field plots (`streamplot` / `quiver`):

```python
import numpy as np
import matplotlib.pyplot as plt

# 3D Surface Plot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
X, Y = np.meshgrid(np.linspace(-2, 2, 50), np.linspace(-2, 2, 50))
Z = np.sin(np.sqrt(X**2 + Y**2))
ax.plot_surface(X, Y, Z, cmap='viridis')
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
plt.show()

# 2D Vector Field (Streamplot)
Y, X = np.mgrid[-2:2:100j, -2:2:100j]
U = -Y
V = X
plt.figure()
plt.streamplot(X, Y, U, V, color=np.sqrt(U**2 + V**2))
plt.title("Vector Field F(x, y) = (-y, x)")
plt.xlabel("x")
plt.ylabel("y")
plt.show()
```

## Interactive Visualizations (Plotly)

When exploring complex 3D surfaces or parametric curves interactively in Jupyter notebooks:

```python
import plotly.graph_objects as go
import numpy as np

x = np.linspace(-5, 5, 100)
y = np.linspace(-5, 5, 100)
X, Y = np.meshgrid(x, y)
Z = np.cos(X) * np.sin(Y)

fig = go.Figure(data=[go.Surface(x=X, y=Y, z=Z)])
fig.update_layout(title='Interactive Surface z = cos(x) sin(y)')
# fig.show()
```

## Numerical experiments

When comparing numerical methods, plot the error whenever possible.

```python
error = np.abs(numerical - reference)

plt.figure()
plt.plot(x, error)
plt.xlabel("x")
plt.ylabel("absolute error")
plt.title("Numerical error")
plt.grid(True)
plt.show()
```

Do not infer exact mathematical equality from a graph.

## Reproducibility

Record:

- relevant parameter values;
- numerical tolerances;
- initial conditions;
- discretization parameters;
- random seeds when randomness is used.

Avoid hidden notebook state.

Record the Python version and important library versions when the result is
version-sensitive. Prefer relative paths, deterministic data generation, and
small cells that can be rerun independently. Save generated figures with
explicit filenames and keep them separate from source notebooks.

## Mathematical verification

Use Jupyter as an experimental layer.

For stronger verification:

- use SymPy for symbolic identities;
- use SciPy for numerical checks;
- use Lean for formal proofs.

Do not describe a visualization or numerical experiment as a proof.

## Numerical stability

When investigating numerical algorithms, check:

- step size;
- floating-point precision;
- convergence;
- conditioning;
- accumulated error;
- tolerance parameters.

If changing numerical parameters substantially changes the result, investigate before drawing conclusions.

For plots, label axes, units, domains, and scales. Use logarithmic axes only
when the transformation is explained. Check for discontinuities, invalid
values, clipping, and misleading interpolation before interpreting a visual
pattern.

## Agent behavior

When the agent uses Jupyter:

1. determine what experiment is needed;
2. construct the smallest useful experiment;
3. execute it;
4. inspect output;
5. compare against expectations;
6. modify the experiment if necessary;
7. preserve important results.

Do not generate dozens of unnecessary plots or notebook cells.

Prefer concise experiments that answer a specific mathematical question.

## Final reporting

When reporting an experiment, distinguish:

- exact symbolic results;
- numerical approximations;
- empirical observations;
- formally verified statements.

A graph can reveal a problem but cannot by itself establish a theorem.
