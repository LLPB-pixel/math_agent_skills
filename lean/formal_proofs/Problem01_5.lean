-- Problema 5: Desigualdad media armónica-geométrica
-- Para x, y > 0, y/x + x/y ≥ 2

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith

theorem media_armonica_geométrica {x y : ℝ} (hx : 0 < x) (hy : 0 < y) : y / x + x / y ≥ 2 := by
  have hxy : 0 < x * y := by positivity
  field_simp
  nlinarith [sq_nonneg (x - y)]
