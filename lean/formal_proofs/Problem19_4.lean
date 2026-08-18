-- Test 89: Lema de Zorn
-- Equivalente al axioma de elección

import Mathlib.Order.Zorn

/-- **Lema de Zorn**: Si cada cadena en un conjunto parcialmente ordenado tiene
    una cota superior, entonces existe un elemento maximal. -/
theorem zorn_lemma {α : Type*} {r : α → α → Prop}
    (h : ∀ c, IsChain r c → ∃ ub, ∀ a ∈ c, r a ub)
    (trans : ∀ {a b c}, r a b → r b c → r a c) :
    ∃ m, ∀ a, r m a → r a m :=
  exists_maximal_of_chains_bounded h trans

/-- Variante del Lema de Zorn para el caso preorder: Si cada cadena acotada tiene cota superior,
    existe un elemento maximal. -/
theorem zorn_lemma_preorder {α : Type*} [Preorder α]
    (h : ∀ c : Set α, IsChain (· ≤ ·) c → BddAbove c) :
    ∃ m : α, IsMax m :=
  zorn_le h
