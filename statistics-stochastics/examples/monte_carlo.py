"""Reproducible Monte Carlo integration with a standard-error report."""

from __future__ import annotations

import numpy as np


def estimate_integral(
    n_samples: int = 100_000, seed: int = 42
) -> tuple[float, float, tuple[float, float]]:
    rng = np.random.default_rng(seed)
    samples = rng.uniform(0.0, 1.0, size=n_samples)
    values = np.exp(-(samples**2))
    estimate = float(values.mean())
    standard_error = float(values.std(ddof=1) / np.sqrt(n_samples))
    interval = (
        estimate - 1.96 * standard_error,
        estimate + 1.96 * standard_error,
    )
    return estimate, standard_error, interval


def main() -> int:
    estimate, standard_error, interval = estimate_integral()
    print(f"estimate: {estimate:.8f}")
    print(f"standard error: {standard_error:.3e}")
    print(f"approximate 95% interval: [{interval[0]:.8f}, {interval[1]:.8f}]")
    print("interpretation: empirical estimate, not an exact evaluation")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
