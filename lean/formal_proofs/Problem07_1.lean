import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith

/-- Problem 31: For all x > 0, ln x ≤ x - 1 -/
theorem log_le_sub_one (x : ℝ) (hx : 0 < x) : Real.log x ≤ x - 1 :=
  Real.log_le_sub_one_of_pos hx
