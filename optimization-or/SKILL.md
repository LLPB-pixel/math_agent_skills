---
name: optimization-or
description: Solve convex optimization, linear programming, mixed-integer programming, non-linear optimization, and analyze duality and KKT conditions using CVXPY, SciPy Optimize, and PuLP.
---

# Optimization & Operations Research

## Purpose

Use this skill to model, solve, and analyze mathematical optimization problems, including:
- Linear Programming (LP) and Mixed-Integer Linear Programming (MILP).
- Convex Optimization (Quadratic Programming, Semidefinite Programming).
- Non-linear constrained optimization.
- Duality theory, dual variables, shadow prices, and Karush-Kuhn-Tucker (KKT) conditions.

Use this skill to formulate an optimization problem before solving it. A
solver result is meaningful only together with the objective convention,
variable domains, constraint directions, solver status, tolerances, and a
feasibility check. Optimization output is generally numerical evidence, not a
formal proof of global optimality.

## Recommended Libraries

- **CVXPY**: Convex optimization modeling (DCP - Disciplined Convex Programming).
- **SciPy (`scipy.optimize`)**: Unconstrained/constrained non-linear optimization (`minimize`), root finding, linear programming (`linprog`).
- **PuLP**: Linear and integer programming formulation with clean algebraic syntax.

Check availability before selecting a backend. The repository includes a
SciPy-only example that does not require CVXPY or PuLP:

```bash
python3 optimization-or/examples/scipy_constrained.py
```

## General Principles

1. **Verify Convexity**: Ensure objective and inequality constraints adhere to disciplined convex rules before calling convex solvers.
2. **Distinguish Primal and Dual**: Extract dual variables (Lagrange multipliers) to analyze constraint sensitivity and shadow prices.
3. **Check Solver Status**: Always verify solver status (`OPTIMAL`, `OPTIMAL_INACCURATE`, `INFEASIBLE`, `UNBOUNDED`, or the solver-specific equivalent) before retrieving variable values.
4. **Distinguish LP/MILP**: Note that Integer/Binary constraints render a problem non-convex and NP-hard.
5. **Validate the returned point**: Recompute constraint residuals and the objective independently; never rely only on a printed status.
6. **State the optimality claim precisely**: A convex problem with a certified solver status supports a stronger claim than a local solution returned by a non-convex method.

Before solving, write down:

- whether the problem is minimization or maximization;
- the units and interpretation of every variable;
- lower/upper bounds and integrality restrictions;
- the sign convention for inequality constraints and dual multipliers;
- whether the data are exact, rounded, or estimated.

## Workflow Examples

### 1. Convex Optimization with CVXPY

```python
import cvxpy as cp
import numpy as np

# Problem data
n = 3
P = np.array([[1.0, 0.4, 0.8], [0.4, 1.0, 0.2], [0.8, 0.2, 1.0]])
q = np.array([-1.0, -2.0, -3.0])

# Define variables
x = cp.Variable(n, nonneg=True)

# Define objective and constraints
objective = cp.Minimize(0.5 * cp.quad_form(x, P) + q.T @ x)
constraints = [cp.sum(x) <= 1.0]

# Formulate and solve problem
prob = cp.Problem(objective, constraints)
prob.solve()

# Results
print(f"Status: {prob.status}")
if prob.status in (cp.OPTIMAL, cp.OPTIMAL_INACCURATE):
    print(f"Optimal Value: {prob.value}")
    print(f"Optimal Solution x: {x.value}")
    print(f"Dual variable (Lagrange multiplier): {constraints[0].dual_value}")
else:
    raise RuntimeError(f"No usable solution: {prob.status}")
```

### 2. Linear & Integer Programming with PuLP

```python
import pulp

# Create LP problem (Maximization)
prob = pulp.LpProblem("Production_Planning", pulp.LpMaximize)

# Decision variables
x1 = pulp.LpVariable("Product1", lowBound=0, cat='Integer')
x2 = pulp.LpVariable("Product2", lowBound=0, cat='Continuous')

# Objective function
prob += 45 * x1 + 30 * x2, "Total_Profit"

# Constraints
prob += 2 * x1 + 1 * x2 <= 100, "Resource_A"
prob += 1 * x1 + 2 * x2 <= 80, "Resource_B"

# Solve
prob.solve()

print(f"Status: {pulp.LpStatus[prob.status]}")
if prob.status == pulp.LpStatusOptimal:
    print(f"x1 = {x1.varValue}, x2 = {x2.varValue}")
    print(f"Optimal Profit = {pulp.value(prob.objective)}")
else:
    raise RuntimeError("The integer program did not return an optimal solution")
```

### 3. Non-Linear Optimization with SciPy (`scipy.optimize`)

```python
import numpy as np
from scipy.optimize import minimize

# Objective function: Rosenbrock function
def objective(x):
    return (1 - x[0])**2 + 100 * (x[1] - x[0]**2)**2

# Inequality constraint: x[0]^2 + x[1]^2 <= 1  =>  1 - x[0]^2 - x[1]^2 >= 0
constraints = ({'type': 'ineq', 'fun': lambda x: 1 - x[0]**2 - x[1]**2})
bounds = [(-2, 2), (-2, 2)]

x0 = np.array([0.0, 0.0])
res = minimize(objective, x0, method='SLSQP', bounds=bounds, constraints=constraints)

print(f"Success: {res.success}")
if res.success:
    print(f"Candidate x: {res.x}")
    print(f"Candidate value: {res.fun}")
    print(f"Constraint residual: {1 - res.x[0]**2 - res.x[1]**2}")
else:
    raise RuntimeError(res.message)
```

## Verification & Sensitivity Checklist

- [ ] Solver status is explicitly checked (`OPTIMAL` or `success==True`).
- [ ] Feasibility of constraints is verified with numerical residual checks.
- [ ] Dual variables are interpreted correctly (non-negative for inequality constraints in standard form).
- [ ] Non-convex models are noted when local minima may differ from global minima.
- [ ] Scaling, tolerances, and numerical conditioning are reported.
- [ ] The objective and all constraints are independently recomputed at the returned point.
- [ ] An infeasible, unbounded, or inaccurate status is reported instead of being treated as a solution.
