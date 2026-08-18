-- Problema 20: Paridad y cuadrados (impar)
-- Demuestra que si n^2 es impar, n es impar

import Mathlib.Algebra.Ring.Parity

theorem paridad_cuadrado_impar {n : ℕ} (h : Odd (n ^ 2)) : Odd n := by
  by_contra he
  have he' : Even n := Nat.not_odd_iff_even.mp he
  have he_sq : Even (n ^ 2) := Even.pow_of_ne_zero he' (by omega)
  rw [Nat.odd_iff] at h
  rw [Nat.even_iff] at he_sq
  omega
