-- Problema 20: Paridad y cuadrados (impar)
-- Si n es par, entonces n² es par (contrapositiva del problema 20)

import Mathlib.Data.Nat.Basic

theorem dua (n : ℕ) (h : 2 ∣ n) : 2 ∣ n * n := by
  obtain ⟨k, hk⟩ := h
  use k * n
  rw [hk]
  omega
