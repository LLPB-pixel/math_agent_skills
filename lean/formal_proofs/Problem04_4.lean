-- Problema 19: Paridad y cuadrados (par)
-- Demuestra que si a^2 es par, a es par

import Mathlib.Algebra.Ring.Parity

theorem paridad_cuadrado_par {a : ℕ} (h : Even (a ^ 2)) : Even a := by
  by_contra ho
  have ho' : Odd a := Nat.not_even_iff_odd.mp ho
  have ho_sq : Odd (a ^ 2) := Odd.pow ho'
  rw [Nat.even_iff] at h
  rw [Nat.odd_iff] at ho_sq
  omega
