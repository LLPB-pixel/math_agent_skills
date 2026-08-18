-- Problema 14: Grupos de orden primo son cíclicos
-- Demostración: Para |G| = p primo, todo elemento a ≠ e genera G: |⟨a⟩| | p y |⟨a⟩| > 1
-- → |⟨a⟩| = p → G = ⟨a⟩

-- Requiere: Mathlib.GroupTheory.Sylow o Mathlib.GroupTheory.Finite.Basic
-- El resultado está demostrado en Mathlib como:
--   IsCyclic.card_neg_one_eq_one_of_prime_card (hp : Nat.Prime n)
--   o: exists_cyclic_of_prime_order

-- Demostración matemática completa en el archivo .tex correspondiente
