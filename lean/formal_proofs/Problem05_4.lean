-- Problema 24: Integral de x^n (indefinida, como antiderivada)
-- Demuestra que la antiderivada de x^n es x^(n+1)/(n+1)
-- Es decir, d/dx(x^(n+1)/(n+1)) = x^n

import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Mul

theorem integral_x_pow_antideriv (n : ℕ) (x : ℝ) (hn : (n : ℝ) + 1 ≠ 0) :
    deriv (fun x : ℝ => x ^ (n + 1) / ((n : ℝ) + 1)) x = x ^ n := by
  have h1 : HasDerivAt (fun x : ℝ => x ^ (n + 1)) ((↑(n + 1) : ℝ) * x ^ n) x :=
    hasDerivAt_pow (n + 1) x
  have h2 : HasDerivAt (fun x : ℝ => x ^ (n + 1) / ((n : ℝ) + 1))
      ((↑(n + 1) : ℝ) * x ^ n / ((n : ℝ) + 1)) x :=
    h1.div_const ((n : ℝ) + 1)
  rw [h2.deriv]
  push_cast
  field_simp
