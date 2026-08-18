-- Problema 3: Suma de cubos con condición
-- Si a + b + c = 0, demuestra que a³ + b³ + c³ = 3abc

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

theorem suma_cubos (a b c : ℝ) (h : a + b + c = 0) : a^3 + b^3 + c^3 = 3 * a * b * c := by
  have hc : c = -(a + b) := by linarith
  subst hc
  ring
