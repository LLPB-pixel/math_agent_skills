-- Problema 16: Pequeño teorema de Fermat
-- Demuestra que a^p ≡ a (mod p) para primo p

import Mathlib.FieldTheory.Finite.Basic

theorem pequeno_teorema_fermat {p : ℕ} (hp : Nat.Prime p) (a : ℤ) :
    a ^ p ≡ a [ZMOD p] :=
  Int.ModEq.pow_prime_eq_self hp a
