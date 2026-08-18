-- Problema 4: Desigualdad cuadrática
-- Demuestra que para x, y ∈ ℝ, (x + y)² ≤ 2(x² + y²)

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

theorem desigualdad_cuadratica (x y : ℝ) : (x + y)^2 ≤ 2 * (x^2 + y^2) := by
  have h : 0 ≤ (x - y)^2 := by positivity
  linarith [sq_nonneg (x - y)]
