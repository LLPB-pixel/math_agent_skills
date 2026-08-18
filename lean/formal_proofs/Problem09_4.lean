-- Problema 9.4: Límite del inverso
-- Si aₙ → a y a ≠ 0, entonces 1/aₙ → 1/a

import Mathlib.Data.Real.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.Algebra.GroupWithZero

open Filter Topology

/-- Si aₙ → a y a ≠ 0, entonces 1/aₙ → 1/a -/
theorem limite_inverso {u : ℕ → ℝ} {a : ℝ}
    (hu : Tendsto u atTop (𝓝 a))
    (ha : a ≠ 0) :
    Tendsto (fun n => (u n)⁻¹) atTop (𝓝 a⁻¹) :=
  Tendsto.inv₀ hu ha
