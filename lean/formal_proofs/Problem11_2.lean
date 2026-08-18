-- Problema 52: Teorema de Bolzano-Weierstrass
-- Toda sucesión acotada tiene subsucesión convergente

import Mathlib.Topology.MetricSpace.Sequences

open Filter Bornology
open scoped Topology

/-- Bolzano-Weierstrass: every bounded sequence in a proper metric space
    has a convergent subsequence. -/
theorem bolzano_weierstrass {X : Type*} [PseudoMetricSpace X] [ProperSpace X]
    {s : Set X} (hs : IsBounded s) {x : ℕ → X} (hx : ∀ n, x n ∈ s) :
    ∃ a ∈ closure s, ∃ φ : ℕ → ℕ, StrictMono φ ∧ Tendsto (x ∘ φ) atTop (𝓝 a) :=
  tendsto_subseq_of_bounded hs hx
