-- Problema 17: Infinitud de primos
-- Demuestra que existen infinitos números primos

import Mathlib.Data.Nat.PrimeFin

theorem infinitud_primos : { p : ℕ | Nat.Prime p }.Infinite :=
  Nat.infinite_setOfPred_prime
