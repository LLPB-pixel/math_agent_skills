-- Problema 50: Continuidad uniforme en compactos (Heine-Cantor)
-- Una función continua en un espacio compacto es uniformemente continua

import Mathlib.Topology.UniformSpace.HeineCantor

open Filter Bornology
open scoped Topology

theorem heine_cantor {α β : Type*} [UniformSpace α] [UniformSpace β]
    [CompactSpace α] {f : α → β} (hf : Continuous f) :
    UniformContinuous f :=
  CompactSpace.uniformContinuous_of_continuous hf
