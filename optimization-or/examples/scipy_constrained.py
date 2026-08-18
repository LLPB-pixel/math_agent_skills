"""Small constrained-optimization example with explicit validation."""

from __future__ import annotations

import numpy as np
from scipy.optimize import minimize


def objective(x: np.ndarray) -> float:
    return float((1 - x[0]) ** 2 + 100 * (x[1] - x[0] ** 2) ** 2)


def disk_residual(x: np.ndarray) -> float:
    """The inequality is written as residual >= 0."""

    return float(1 - x[0] ** 2 - x[1] ** 2)


def main() -> int:
    result = minimize(
        objective,
        x0=np.array([0.0, 0.0]),
        method="SLSQP",
        bounds=[(-2.0, 2.0), (-2.0, 2.0)],
        constraints={"type": "ineq", "fun": disk_residual},
        options={"ftol": 1e-12, "maxiter": 500},
    )

    if not result.success:
        raise RuntimeError(result.message)
    residual = disk_residual(result.x)
    if residual < -1e-8:
        raise RuntimeError(f"infeasible result: residual={residual}")

    print(f"status: {result.message}")
    print(f"candidate: {result.x}")
    print(f"objective: {result.fun:.12g}")
    print(f"constraint residual: {residual:.3e}")
    print("claim: local numerical candidate; global optimality requires additional analysis")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
