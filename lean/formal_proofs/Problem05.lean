-- Problema 5: Desigualdad media armónica-geométrica
-- Demuestra que para x, y > 0, y/x + x/y ≥ 2

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

theorem media_armonica_geometrica (x y : ℝ) (hx : 0 < x) (hy : 0 < y) :
    y / x + x / y ≥ 2 := by
  have hx_ne : x ≠ 0 := ne_of_gt hx
  have hy_ne : y ≠ 0 := ne_of_gt hy
  field_simp
  nlinarith [sq_nonneg (x - y)]
