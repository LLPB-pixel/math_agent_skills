-- Problema 7: Cota en el círculo unitario
-- Si x² + y² = 1, entonces (x+y)² ≤ 2
-- Equivalente: demostrar que x² + y² ≤ 1 → (x+y)² ≤ 2

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

theorem cota_circulo (x y : ℝ) (h : x^2 + y^2 = 1) : (x + y)^2 ≤ 2 := by
  have h1 : (x - y)^2 ≥ 0 := by nlinarith
  nlinarith
