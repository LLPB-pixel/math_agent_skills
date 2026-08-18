-- Problema 9.5: Completeza de ℝ
-- Toda sucesión de Cauchy en ℝ converge

import Mathlib.Data.Real.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.UniformSpace.Real

open Filter Topology

/-- Toda sucesión de Cauchy en ℝ converge a un límite. -/
theorem cauchy_converge (u : ℕ → ℝ) (h : CauchySeq u) :
    ∃ a : ℝ, Tendsto u atTop (𝓝 a) :=
  cauchySeq_tendsto_of_complete h
