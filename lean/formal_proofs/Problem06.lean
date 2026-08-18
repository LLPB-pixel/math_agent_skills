-- Problema 6: Desigualdad de Nesbitt
-- Demuestra que si a, b, c > 0, (a + b + c)(1/a + 1/b + 1/c) ≥ 9

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

theorem nesbitt (a b c : ℝ) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    (a + b + c) * (1/a + 1/b + 1/c) ≥ 9 := by
  have ha_ne : a ≠ 0 := ne_of_gt ha
  have hb_ne : b ≠ 0 := ne_of_gt hb
  have hc_ne : c ≠ 0 := ne_of_gt hc
  field_simp
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (a - c)]
