-- Problema 6: Desigualdad de Nesbitt
-- Si a, b, c > 0, entonces (a + b + c)(1/a + 1/b + 1/c) ≥ 9

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp

theorem nesbitt_inequality (a b c : ℝ) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    (a + b + c) * (1 / a + 1 / b + 1 / c) ≥ 9 := by
  have ha' : a ≠ 0 := ne_of_gt ha
  have hb' : b ≠ 0 := ne_of_gt hb
  have hc' : c ≠ 0 := ne_of_gt hc
  have habc : 0 < a * b * c := by positivity
  rw [show 1 / a + 1 / b + 1 / c = (b * c + c * a + a * b) / (a * b * c) from by
    rw [add_div, add_div]; congr 1; rw [div_eq_div_iff]; ring; exact hb'; exact hc'; exact ha']
  rw [mul_div, ge_iff_le, div_le_div_iff (by positivity) (by positivity)]
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (c - a)]
