-- Problema 26: Integral de sin x
-- ∫_0^π sin x dx = 2

import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Tactic.NormNum

open Real in
theorem integral_sin_pi : ∫ x in (0:ℝ)..π, sin x = 2 := by
  simp only [integral_sin, cos_zero, cos_pi]
  norm_num
