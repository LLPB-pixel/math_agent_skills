-- Problema 8: Identidad con suma nula
-- Si x + y + z = 0, entonces x² + y² + z² = -2(xy + xz + yz)

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

theorem suma_nula (x y z : ℝ) (h : x + y + z = 0) :
    x^2 + y^2 + z^2 = -2 * (x*y + x*z + y*z) := by
  have h2 : (x + y + z)^2 = 0 := by rw [h]; ring
  ring_nf at h2
  linarith
