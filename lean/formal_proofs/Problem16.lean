-- Problema 16: Pequeño teorema de Fermat
-- Demuestra que aᵖ ≡ a (mod p) para todo primo p y todo a ∈ ℤ

import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Linarith

-- Requiere Mathlib.GroupTheory.Sylow o ring_theory/fermat
-- El resultado está en Mathlib como Nat.pow_modEq_self
-- o: a ^ p ≡ a [MOD p] cuando p es primo
