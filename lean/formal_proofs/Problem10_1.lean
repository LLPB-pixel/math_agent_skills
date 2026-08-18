-- Problema 46: Subsucesión convergente
-- Toda sucesión acotada tiene subsucesión convergente (Bolzano-Weierstrass)

import Mathlib.Topology.MetricSpace.Sequences

open Filter Bornology
open scoped Topology

theorem bounded_seq_has_convergent_subseq {X : Type*} [PseudoMetricSpace X] [ProperSpace X]
    {s : Set X} (hs : IsBounded s) {x : ℕ → X} (hx : ∀ n, x n ∈ s) :
    ∃ a ∈ closure s, ∃ φ : ℕ → ℕ, StrictMono φ ∧ Tendsto (x ∘ φ) atTop (𝓝 a) :=
  tendsto_subseq_of_bounded hs hx
