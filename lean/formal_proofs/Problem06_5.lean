-- Problema 30: Desigualdad e^x >= 1 + x
-- Para todo x real, exp x >= 1 + x

import Mathlib.Analysis.Complex.Exponential

theorem exp_ge_one_add (x : ℝ) : 1 + x ≤ Real.exp x := by
  rw [add_comm]
  exact Real.add_one_le_exp x
