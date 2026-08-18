-- Problema 68: Independencia y esperanza del producto
-- Si X, Y independientes, entonces E[XY] = E[X]·E[Y]

import Mathlib.Probability.Independence.Integration

open MeasureTheory Filter Finset

open scoped MeasureTheory ProbabilityTheory ENNReal NNReal

/-- Si X e Y son variables aleatorias independientes con medibilidad fuerte,
    entonces E[XY] = E[X]·E[Y].
    Demostración directa del teorema `integral_fun_mul_eq_mul_integral` de Mathlib. -/
theorem expectation_product_of_independence
    {Ω : Type*} {mΩ : MeasurableSpace Ω} {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} (hXY : X ⟂ᵢ[μ] Y)
    (hX : AEStronglyMeasurable X μ) (hY : AEStronglyMeasurable Y μ) :
    ∫ ω, X ω * Y ω ∂μ = (∫ ω, X ω ∂μ) * (∫ ω, Y ω ∂μ) :=
  ProbabilityTheory.IndepFun.integral_fun_mul_eq_mul_integral hXY hX hY
