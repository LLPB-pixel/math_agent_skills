-- Problema 69: Varianza de transformación afín
-- Var(aX + b) = a²·Var(X)

import Mathlib.Probability.Moments.Variance

open MeasureTheory Filter Finset

open scoped MeasureTheory ProbabilityTheory ENNReal NNReal

/-- La varianza de una transformación afín aX + b es a²·Var(X).
    Se utiliza que Var(aX + b) = Var(aX) (la constante additiva no afecta)
    y Var(aX) = a²·Var(X) (propiedad de escalamiento). -/
theorem variance_affine_transform
    {Ω : Type*} {mΩ : MeasurableSpace Ω} {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X : Ω → ℝ} (hX : AEStronglyMeasurable X μ) (a b : ℝ) :
    Var[fun ω ↦ a * X ω + b; μ] = a ^ 2 * Var[X; μ] := by
  -- Paso 1: Var(aX + b) = Var(aX) (la constante aditiva no afecta la varianza)
  rw [ProbabilityTheory.variance_add_const (hX.const_mul a) b]
  -- Paso 2: Var(aX) = a²·Var(X) (propiedad de escalamiento)
  exact ProbabilityTheory.variance_const_mul a X μ
