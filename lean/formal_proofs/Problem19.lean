-- Problema 19: Paridad y cuadrados (par)
-- Si a² es par, entonces a es par

import Mathlib.Data.Nat.Prime.Basic

theorem cuadrado_par_implica_par (a : ℕ) (h : 2 ∣ a^2) : 2 ∣ a :=
  Nat.Prime.dvd_of_dvd_pow Nat.prime_two h
