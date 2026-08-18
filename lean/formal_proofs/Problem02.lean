-- Problema 2: Trinomio al cuadrado
-- Demuestra que para a, b, c ∈ ℝ, (a + b + c)² = a² + b² + c² + 2ab + 2ac + 2bc

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

theorem trinomio_al_cuadrado (a b c : ℝ) :
    (a + b + c)^2 = a^2 + b^2 + c^2 + 2*a*b + 2*a*c + 2*b*c := by
  ring
