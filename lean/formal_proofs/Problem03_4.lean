-- Problema 14: Grupos de orden primo son cíclicos
-- Demostración: Para |G| = p primo, todo grupo de orden primo es cíclico.
--
-- En Mathlib, `isCyclic_of_prime_card` establece que un grupo finito
-- de orden primo es cíclico.

import Mathlib.GroupTheory.SpecificGroups.Cyclic.Basic

theorem grupos_primo_ciclicos {G : Type*} [Group G] [Finite G]
    {p : ℕ} [Fact p.Prime] (h : Nat.card G = p) : IsCyclic G :=
  isCyclic_of_prime_card h
