import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

-- Test: ring tactic
theorem test_ring (a b : ℝ) : (a + b)^2 = a^2 + 2*a*b + b^2 := by
  ring

-- Test: linarith
theorem test_linarith (x y : ℝ) (hx : 0 < x) (hy : 0 < y) : 0 < x + y := by
  linarith

-- Test: positivity
theorem test_positivity (a b : ℝ) (ha : 0 < a) (hb : 0 < b) : 0 < a^2 + b^2 := by
  positivity
