-- Problema 66: Linealidad de la esperanza
-- E[X + Y] = E[X] + E[Y]

import Mathlib.MeasureTheory.Integral.Bochner.Basic

open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- Linealidad de la esperanza: E[X + Y] = E[X] + E[Y] -/
theorem expectation_add {X Y : Ω → ℝ}
    (hX : Integrable X μ) (hY : Integrable Y μ) :
    ∫ ω, X ω + Y ω ∂μ = ∫ ω, X ω ∂μ + ∫ ω, Y ω ∂μ :=
  integral_add hX hY
