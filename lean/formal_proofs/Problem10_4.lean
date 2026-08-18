-- Problema 49: Continuidad uniforme y Cauchy
-- Una función uniformemente continua preserva sucesiones de Cauchy

import Mathlib.Topology.UniformSpace.Cauchy

open Filter Bornology
open scoped Topology

theorem uniform_continuous_preserves_cauchy {α β : Type*} [UniformSpace α] [UniformSpace β]
    {f : α → β} (hf : UniformContinuous f) {u : ℕ → α} (hu : CauchySeq u) :
    CauchySeq (f ∘ u) :=
  UniformContinuous.comp_cauchySeq hf hu
