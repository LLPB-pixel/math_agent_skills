-- Problema 1: Binomio al cubo
-- Para todo a, b ∈ ℝ, (a + b)^3 = a^3 + 3a^2b + 3ab^2 + b^3

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

theorem binomio_al_cubo (a b : ℝ) : (a + b)^3 = a^3 + 3 * a^2 * b + 3 * a * b^2 + b^3 := by
  ring
