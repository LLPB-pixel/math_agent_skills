-- Problema 8.5: Sucesiones monótonas y acotadas convergen
-- Toda sucesión monótona y acotada converge

import Mathlib.Topology.Order.MonotoneConvergence
import Mathlib.Topology.MetricSpace.Cauchy

/-- **Sucesiones monótonas y acotadas convergen**:
    Si u : ℕ → ℝ es monótona creciente y acotada superiormente, entonces converge. -/
theorem tendsto_of_monotone_bounded {u : ℕ → ℝ}
    (hu : Monotone u) (hbdd : BddAbove (Set.range u)) :
    ∃ l : ℝ, Filter.Tendsto u Filter.atTop (nhds l) :=
  ⟨⨆ n, u n, tendsto_atTop_ciSup hu hbdd⟩