-- Problema 7: Cota en el círculo unitario
-- Si x² + y² = 1, entonces |x + y| ≤ √2

import Mathlib.Data.Real.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

theorem unit_circle_bound (x y : ℝ) (h : x ^ 2 + y ^ 2 = 1) : |x + y| ≤ Real.sqrt 2 := by
  have h1 : (x + y) ^ 2 ≤ 2 := by nlinarith [sq_nonneg (x - y)]
  rw [← Real.sqrt_sq (abs_nonneg (x + y)), sq_abs]
  exact Real.sqrt_le_sqrt h1
