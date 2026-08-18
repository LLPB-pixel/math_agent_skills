---
name: statistics-stochastics
description: Perform probability distribution analysis, stochastic processes, Markov chain simulation, Monte Carlo methods, and Bayesian statistical modeling using SciPy stats and PyMC.
---

# Statistics, Probability & Stochastic Processes

## Purpose

Use this skill for probabilistic modeling, stochastic analysis, statistical inference, and Monte Carlo experimentation, including:
- Probability distribution analysis (PDF, CDF, PPF, moments, sampling).
- Discrete and continuous Markov chains (transition matrices, stationary distributions, absorbing states).
- Stochastic process simulation (Brownian motion, Poisson processes, random walks).
- Monte Carlo estimation and variance reduction.
- Bayesian inference and parameter estimation with PyMC.

Use this skill when randomness is part of the model or when uncertainty must
be quantified. Keep theoretical quantities (expectations, laws, stationary
distributions) separate from estimates obtained from a finite sample.

SciPy, PyMC, and plotting libraries are optional environment capabilities. If
one is unavailable, report that limitation and do not silently replace a
Bayesian or stochastic calculation with a deterministic approximation.

A minimal NumPy-only Monte Carlo example is available at:

```bash
python3 statistics-stochastics/examples/monte_carlo.py
```

## Core Principles

1. **Distinguish Empirical from Theoretical**: Empirical sample means/variances converge to theoretical moments as $N \to \infty$ by the Law of Large Numbers, but finite sample statistics carry sampling error.
2. **Always State Uncertainty**: When reporting Monte Carlo estimates, include standard error or a confidence interval ($\hat{\mu} \pm 1.96 \frac{s}{\sqrt{N}}$ is a normal approximation, not a universal guarantee). State the estimator, sample size, and interval assumptions.
3. **Verify Markov Chain Properties**: Check irreducibility, aperiodicity, and stationary distribution condition ($\pi P = \pi, \sum \pi_i = 1$).
4. **Reproducibility**: Set explicit random seeds (`np.random.default_rng(seed)`).
5. **Respect dependence**: For time series, Markov chains, MCMC, and variance-reduction methods, do not use an i.i.d. standard-error formula without accounting for autocorrelation.
6. **Check support and parameters**: Validate that probabilities sum to one and that samples lie in the stated support before fitting or simulating.

## Workflow Examples

### 1. Markov Chains & Stationary Distributions

```python
import numpy as np

# Transition probability matrix P (rows sum to 1)
P = np.array([
    [0.7, 0.2, 0.1],
    [0.3, 0.5, 0.2],
    [0.2, 0.4, 0.4]
])

if not np.allclose(P.sum(axis=1), 1.0):
    raise ValueError("Each row of P must sum to one")
if np.any(P < 0):
    raise ValueError("Transition probabilities must be non-negative")

# Compute stationary distribution pi where pi * P = pi and sum(pi) = 1
# Equivalent to solving (P.T - I) * pi = 0 with sum(pi) = 1
eigenvalues, eigenvectors = np.linalg.eig(P.T)
# Find eigenvector corresponding to eigenvalue 1
idx = np.argmin(np.abs(eigenvalues - 1.0))
pi = np.real(eigenvectors[:, idx])
pi = pi / np.sum(pi)  # Normalize

print(f"Stationary Distribution pi = {pi}")
print(f"Verification pi * P = {pi @ P}")
print(f"Residual = {np.max(np.abs(pi @ P - pi))}")
```

### 2. Monte Carlo Integration with Standard Error

```python
import numpy as np

def monte_carlo_integral(func, a, b, n_samples=1_000_000, seed=42):
    rng = np.random.default_rng(seed)
    x = rng.uniform(a, b, size=n_samples)
    y = func(x)
    
    integral_est = (b - a) * np.mean(y)
    std_error = (b - a) * np.std(y, ddof=1) / np.sqrt(n_samples)
    ci_95 = (integral_est - 1.96 * std_error, integral_est + 1.96 * std_error)
    
    return integral_est, std_error, ci_95

# Example: Estimate integral of exp(-x^2) from 0 to 1
est, se, ci = monte_carlo_integral(lambda x: np.exp(-x**2), 0, 1)
print(f"Estimate: {est:.6f} +/- {se:.6f}")
print(f"95% CI: [{ci[0]:.6f}, {ci[1]:.6f}]")

# The interval is an approximate sampling interval under a CLT/normal
# approximation; it is not a proof that the exact integral lies in this one
# realized interval.
```

### 3. Continuous Stochastic Process (Geometric Brownian Motion)

```python
import numpy as np
import matplotlib.pyplot as plt

def simulate_gbm(S0, mu, sigma, T, N, n_paths, seed=42):
    rng = np.random.default_rng(seed)
    dt = T / N
    t = np.linspace(0, T, N + 1)
    
    # Wiener process increments
    dW = rng.normal(0, np.sqrt(dt), size=(n_paths, N))
    W = np.cumsum(dW, axis=1)
    W = np.hstack([np.zeros((n_paths, 1)), W])
    
    # Geometric Brownian Motion path formula
    S = S0 * np.exp((mu - 0.5 * sigma**2) * t + sigma * W)
    return t, S

t, S = simulate_gbm(S0=100, mu=0.05, sigma=0.2, T=1.0, N=252, n_paths=5)
plt.figure()
plt.plot(t, S.T)
plt.xlabel("Time t")
plt.ylabel("S(t)")
plt.title("Geometric Brownian Motion Trajectories")
plt.grid(True)
plt.show()
```

## Checklist

- [ ] Random seed is set explicitly.
- [ ] Monte Carlo estimates report standard error or confidence intervals.
- [ ] Markov chain transition matrices are validated (rows sum to 1).
- [ ] Empirical simulations are compared against theoretical closed-form expressions whenever possible.
- [ ] The dependence structure and effective sample size are considered.
- [ ] Confidence-interval assumptions and units are stated.
- [ ] Burn-in, thinning, convergence diagnostics, and multiple chains are reported for MCMC.
- [ ] A simulation result is not described as an exact theorem.
