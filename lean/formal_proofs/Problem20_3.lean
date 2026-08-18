-- Test 93: Teorema de Baire
-- La intersección numerable de abiertos densos es densa.

import Mathlib.Topology.Baire.Lemmas

/-- Teorema de Baire: en un espacio de Baire, la intersección numerable de
    conjuntos abiertos densos es densa. -/
theorem baire_category_theorem
    {X : Type*} [TopologicalSpace X] [BaireSpace X]
    {f : ℕ → Set X} (ho : ∀ n, IsOpen (f n)) (hd : ∀ n, Dense (f n)) :
    Dense (⋂ n, f n) :=
  dense_iInter_of_isOpen_nat ho hd
