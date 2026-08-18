-- Problema 9.2: Unicidad del límite
-- El límite de una sucesión convergente es único

import Mathlib.Data.Real.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.Separation.Hausdorff

open Filter Topology

/-- El límite de una sucesión convergente en un espacio Hausdorff es único. -/
theorem limite_unico {u : ℕ → ℝ} {a b : ℝ}
    (ha : Tendsto u atTop (𝓝 a))
    (hb : Tendsto u atTop (𝓝 b)) :
    a = b :=
  tendsto_nhds_unique ha hb
