-- Problema 10: Determinante de la inversa
-- Si A es invertible, det(A⁻¹) = 1/det(A)

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp

theorem det_inversa (a b c d : ℝ) (h : a * d - b * c ≠ 0) :
    (a * d - b * c) * ((a * d - b * c) / (a * d - b * c) ^ 2) = 1 := by
  field_simp
