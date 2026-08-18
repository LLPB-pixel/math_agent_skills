-- Problema 10: Determinante de la inversa
-- Si A es invertible, det(A⁻¹) = 1/det(A)
-- Demostrado para matrices 2×2: A = [[a,b],[c,d]]

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

theorem det_inversa (a b c d : ℝ) (h : a * d - b * c ≠ 0) :
    (d / (a * d - b * c)) * (a / (a * d - b * c)) -
    (-b / (a * d - b * c)) * (-c / (a * d - b * c)) =
    1 / (a * d - b * c) := by
  field_simp
  ring
