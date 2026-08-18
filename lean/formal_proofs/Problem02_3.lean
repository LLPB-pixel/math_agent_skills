-- Problema 8: Identidad con suma nula
-- Si x + y + z = 0, entonces x² + y² + z² = -2(xy + xz + yz)

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

theorem sum_zero_identity (x y z : ℝ) (h : x + y + z = 0) :
    x ^ 2 + y ^ 2 + z ^ 2 = -2 * (x * y + x * z + y * z) := by
  nlinarith [sq_nonneg (x + y + z)]
