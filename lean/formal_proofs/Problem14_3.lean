-- Problema 64: Fórmula de Bayes
-- P(A|B) = P(B|A) * P(A) / P(B)

import Mathlib.Probability.ConditionalProbability

open MeasureTheory ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsFiniteMeasure μ]
  {A B : Set Ω}

/-- Fórmula de Bayes: P(A|B) = P(B|A) * P(A) / P(B) -/
theorem bayes_formula (hA : MeasurableSet A) (hB : MeasurableSet B) :
    μ[A | B] = (μ B)⁻¹ * μ[B | A] * μ A :=
  cond_eq_inv_mul_cond_mul hB hA μ
