-- Problema 9.3: Límite del producto
-- Si aₙ → a y bₙ → b, entonces aₙbₙ → ab

import Mathlib.Data.Real.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.Algebra.Monoid.Defs

open Filter Topology

/-- Si aₙ → a y bₙ → b, entonces aₙbₙ → ab -/
theorem limite_producto {u v : ℕ → ℝ} {a b : ℝ}
    (hu : Tendsto u atTop (𝓝 a))
    (hv : Tendsto v atTop (𝓝 b)) :
    Tendsto (fun n => u n * v n) atTop (𝓝 (a * b)) :=
  Tendsto.mul hu hv
