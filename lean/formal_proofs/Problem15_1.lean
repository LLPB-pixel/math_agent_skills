-- Problema 67: Varianza en función de los momentos
-- Var(X) = E[X²] - (E[X])²

import Mathlib.Probability.Moments.Variance

open MeasureTheory Filter Finset

open scoped MeasureTheory ProbabilityTheory ENNReal NNReal

/-- Para una variable aleatoria real X en L² sobre una medida de probabilidad,
    la varianza es E[X²] - (E[X])².
    Demostración directa del teorema `variance_eq_sub` de Mathlib. -/
theorem variance_eq_E_sq_sub_E_sq
    {Ω : Type*} {mΩ : MeasurableSpace Ω} {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X : Ω → ℝ} (hX : MemLp X 2 μ) :
    Var[X; μ] = μ[X ^ 2] - μ[X] ^ 2 :=
  ProbabilityTheory.variance_eq_sub hX
