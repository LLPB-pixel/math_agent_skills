import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Gcongr

-- Example 1: Polynomial identity using `ring`
theorem square_expansion (x y : ℝ) : (x + y)^2 = x^2 + 2*x*y + y^2 := by
  ring

-- Example 2: Structured derivation using `calc`
theorem difference_of_squares (a b : ℝ) : (a + b) * (a - b) = a^2 - b^2 := by
  calc
    (a + b) * (a - b) = a * a - a * b + b * a - b * b := by ring
    _                 = a^2 - b^2                    := by ring

-- Example 3: Positivity tactic
theorem sum_of_squares_positive (a b : ℝ) (ha : 0 < a) (hb : 0 < b) : 0 < a^2 + b^2 := by
  positivity

-- Example 4: Generalized congruence using `gcongr`
theorem inequality_congruence (a b c d : ℝ) (h1 : a ≤ b) (h2 : c ≤ d) : a + c ≤ b + d := by
  gcongr
