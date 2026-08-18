-- Problema 12: Autovalores de matrices idempotentes
-- Si A² = A, entonces los autovalores de A son 0 o 1
--
-- Demostración matemática:
-- Si λ es autovalor de A con Av = λv, entonces:
-- A²v = A(Av) = A(λv) = λAv = λ²v
-- Pero A² = A, así que Av = λv = λ²v
-- Como v ≠ 0, tenemos λ = λ², luego λ(λ-1) = 0
-- Por lo tanto λ = 0 o λ = 1

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

theorem autovalores_idempotentes (lam : ℝ) (h : lam^2 = lam) : lam = 0 ∨ lam = 1 := by
  have h2 : lam * (lam - 1) = 0 := by linarith
  rcases mul_eq_zero.mp h2 with h_eq | h_eq
  · left; exact h_eq
  · right; linarith
