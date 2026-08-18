---
name: python-scientific
description: Use Python with NumPy, SciPy, SymPy, and Matplotlib for numerical computation, symbolic mathematics, differential equations, linear algebra, statistics, plotting, and independent verification of mathematical results.
---

# Python Scientific Computing

## Purpose

Use this environment for mathematical experimentation, symbolic manipulation, numerical computation, numerical verification, and plotting.

Use this skill when the task needs a calculator, an exact symbolic derivation,
a numerical approximation, a plot, or an independent computational check. It
is not a replacement for a proof assistant: computational output must remain
labelled as computational evidence.

The primary libraries are:

- NumPy: numerical arrays and linear algebra.
- SciPy: numerical algorithms, integration, optimization, interpolation, statistics, ODEs, FFTs, and scientific computing.
- SymPy: symbolic mathematics.
- Matplotlib: visualization.

Use this environment as an independent calculator and verifier. Do not assume that the model's reasoning is correct merely because Python executes successfully.

## General rules

1. Prefer exact symbolic computation with SymPy when the problem is symbolic.
2. Prefer NumPy/SciPy for numerical computation.
3. Use both symbolic and numerical approaches when they provide independent checks.
4. Never silently replace an exact symbolic result with a floating-point approximation.
5. Explicitly distinguish exact results from numerical approximations.
6. Check dimensions, domains, assumptions, boundary conditions, and initial conditions.
7. When verifying a derivation, test intermediate results whenever practical.
8. Do not use numerical agreement at a few points as proof of a mathematical identity.
9. Do not claim that a calculation has been mathematically proven merely because SymPy returned an expression.
10. If SymPy cannot simplify or prove something, report that limitation instead of assuming the statement is true.

## Symbolic mathematics

Use SymPy for differentiation, integration, limits, series, solving equations, systems of equations, matrix algebra, polynomial manipulation, simplification, symbolic ODEs, and symbolic linear algebra.

Example:

```python
import sympy as sp

x = sp.symbols("x")
f = x**2 * sp.exp(x)

derivative = sp.diff(f, x)
integral = sp.integrate(f, x)
```

Prefer symbolic quantities over floating-point values. When useful, obtain both exact and numerical forms.

## Verification of symbolic identities

To test an identity:

```python
difference = sp.simplify(lhs - rhs)
```

Accept the identity as symbolically verified only when SymPy reduces the difference to exactly zero.

Be aware that failure to simplify to zero does not necessarily imply that the identity is false. State this limitation.

For a reproducible command-line check, use the helper shipped with this skill:

```bash
python3 python-scientific/scripts/verify_identity.py \
  "sin(2*x)" "2*sin(x)*cos(x)" --digits 50 --seed 42
```

The helper first simplifies the difference symbolically and then evaluates it
at deterministic exact points (including additional rational points generated
from the supplied seed). Singular points are reported and skipped. By default
it accepts one variable; expressions containing undeclared extra symbols are
rejected rather than silently left unevaluated. A successful numerical check is
corroboration, not a proof.

## Numerical computation

Use NumPy and SciPy for numerical integration, differentiation, root finding, optimization, linear algebra, interpolation, numerical ODEs, Fourier transforms, probability distributions, and statistical tests.

Use SciPy instead of manually implementing standard numerical algorithms unless the educational purpose explicitly requires implementation from scratch.

For floating-point comparisons, use tolerances such as:

```python
np.testing.assert_allclose(
    numerical,
    analytical,
    rtol=1e-8,
    atol=1e-10
)
```

Never use exact equality for floating-point results.

For every numerical result, record the algorithm, precision, tolerances,
initial/boundary conditions, and relevant conditioning assumptions. A solver
returning a number is not evidence that the problem was posed correctly.

## High-precision arithmetic (`mpmath`)

When standard IEEE 754 `float64` suffers from catastrophic cancellation, ill-conditioned matrices, or loss of precision, use `mpmath` for arbitrary-precision floating-point computation:

```python
import mpmath as mp

mp.dps = 50  # Set precision to 50 decimal places
val = mp.quad(lambda x: mp.exp(-x**2), [0, mp.inf])
expected = mp.sqrt(mp.pi) / 2
assert mp.almosteq(val, expected, rel_eps=1e-45)
```

## Linear algebra

Use SymPy for exact matrix operations (characteristic polynomials, Jordan canonical form, exact eigenspaces, rank, nullspace):

```python
import sympy as sp

A = sp.Matrix([[1, 2], [3, 4]])
P, J = A.jordan_form()  # Exact Jordan decomposition
eigenvals = A.eigenvals()  # Exact eigenvalues
```

Use NumPy/SciPy (`numpy.linalg`, `scipy.linalg`) for numerical linear algebra on large matrices. Always distinguish exact from numerical results.

## Plotting

Use Matplotlib for visual inspection of signs, discontinuities, boundary conditions, numerical instability, and unexpected behavior.

A plot is evidence for behavior, not a mathematical proof.

## Errors and uncertainty

If a computation fails:

1. inspect the error;
2. determine whether the mathematical formulation is wrong;
3. determine whether the API was used incorrectly;
4. try a simpler equivalent formulation;
5. report unresolved failures.

Never fabricate a result when a tool fails.

If a computation is domain-sensitive, report excluded points and branch
choices explicitly (for example, logarithms, roots, inverse trigonometric
functions, and denominators). If a symbolic transformation is only valid under
assumptions, state those assumptions instead of presenting the transformed
expression as universally valid.

## Output

When using Python as a verifier, report:

- the computation performed;
- the relevant result;
- whether verification succeeded;
- whether the result is exact or numerical;
- any assumptions or limitations.

Keep mathematical reasoning separate from computational evidence.
