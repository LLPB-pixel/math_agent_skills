-- Problema 21: Derivada de x^n
-- Demuestra que d/dx(x^n) = n * x^(n-1)

import Mathlib.Analysis.Calculus.Deriv.Pow

-- Para x ∈ ℝ y n ∈ ℕ, la derivada de la función x ↦ x^n es n * x^(n-1)
theorem deriv_x_pow (n : ℕ) (x : ℝ) :
    deriv (fun x : ℝ => x ^ n) x = (n : ℝ) * x ^ (n - 1) := by
  exact deriv_pow_field n
