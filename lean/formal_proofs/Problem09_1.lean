-- Problema 9.1: Convergente implica acotada
-- Toda sucesión convergente es acotada

import Mathlib.Data.Real.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.Order.LiminfLimsup

open Filter Topology

/-- Toda sucesión convergente en ℝ tiene la imagen acotada superiormente. -/
theorem convergente_bddAbove {u : ℕ → ℝ} {a : ℝ}
    (h : Tendsto u atTop (𝓝 a)) :
    BddAbove (Set.range u) :=
  Filter.Tendsto.bddAbove_range h

/-- Toda sucesión convergente en ℝ tiene la imagen acotada inferiormente. -/
theorem convergente_bddBelow {u : ℕ → ℝ} {a : ℝ}
    (h : Tendsto u atTop (𝓝 a)) :
    BddBelow (Set.range u) :=
  Filter.Tendsto.bddBelow_range h
