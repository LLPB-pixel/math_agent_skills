
import Mathlib.Probability.Moments.Variance
open MeasureTheory
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} {X Y : Ω → ℝ}
    (hX : MemLp X 2 μ) (hY : MemLp Y 2 μ) : Integrable (X * Y) μ :=
  MemLp.integrable_mul hX hY

