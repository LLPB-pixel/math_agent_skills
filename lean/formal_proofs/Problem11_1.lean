-- Problema 51: Extremos en compactos
-- Función continua en compacto alcanza máximo y mínimo (Teorema de los Extremos)

import Mathlib.Data.Real.Basic
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Topology.Order.Compact
import Mathlib.Order.Interval.Set.Basic

open Filter Bornology
open scoped Topology

/-- A continuous function on a compact set attains its minimum. -/
theorem compact_attains_min {f : ℝ → ℝ} {s : Set ℝ}
    (hs : IsCompact s) (hne : s.Nonempty) (hf : ContinuousOn f s) :
    ∃ x ∈ s, IsMinOn f s x :=
  hs.exists_isMinOn hne hf

/-- A continuous function on a compact set attains its maximum. -/
theorem compact_attains_max {f : ℝ → ℝ} {s : Set ℝ}
    (hs : IsCompact s) (hne : s.Nonempty) (hf : ContinuousOn f s) :
    ∃ x ∈ s, IsMaxOn f s x :=
  hs.exists_isMaxOn hne hf
