-- Problema 1: Binomio al cubo
-- Demuestra que para todo a, b ∈ ℝ, (a + b)³ = a³ + 3a²b + 3ab² + b³

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

theorem binomio_al_cubo (a b : ℝ) : (a + b)^3 = a^3 + 3 * a^2 * b + 3 * a * b^2 + b^3 := by
  ring
