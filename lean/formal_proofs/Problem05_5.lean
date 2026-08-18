-- Problema 25: Integral definida de x^n de 0 a 1
-- Demuestra que ∫₀¹ x^n dx = 1/(n+1)

import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

-- Para n ∈ ℕ, la integral definida de 0 a 1 de x^n es 1/(n+1)
theorem integral_01_x_pow (n : ℕ) :
    ∫ x in (0 : ℝ)..1, x ^ n = 1 / ((n : ℝ) + 1) := by
  rw [integral_pow]
  simp
