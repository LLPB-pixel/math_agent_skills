-- Test 98: Teorema de Bayes general
-- P(A|B) = P(B|A) * P(A) / P(B) en espacio de probabilidad general

import Mathlib.Probability.ConditionalProbability

open MeasureTheory ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsFiniteMeasure μ]

/-- **Teorema de Bayes general**: Para eventos medibles A, B,
    la probabilidad condicional de A dado B es:
    μ(A|B) = (μ B)⁻¹ * μ(B|A) * μ(A). -/
theorem bayes_general
    {A B : Set Ω} (hA : MeasurableSet A) (hB : MeasurableSet B) :
    μ[A | B] = (μ B)⁻¹ * μ[B | A] * μ A :=
  cond_eq_inv_mul_cond_mul hB hA μ

/-- **Teorema de Bayes (forma alternativa)**: Reescribiendo, obtenemos:
    μ(A|B) * μ(B) = μ(B|A) * μ(A). -/
theorem bayes_general_mul
    {A B : Set Ω} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hB_pos : 0 < μ B) :
    μ[A | B] * μ B = μ[B | A] * μ A := by
  rw [bayes_general hA hB]
  rw [show ((μ B)⁻¹ * μ[B | A] * μ A) * μ B = μ[B | A] * μ A from by
    calc ((μ B)⁻¹ * μ[B | A] * μ A) * μ B
        = ((μ B)⁻¹ * (μ[B | A] * μ A)) * μ B := by ring
      _ = (μ B)⁻¹ * (μ[B | A] * μ A * μ B) := by ring
      _ = (μ B)⁻¹ * (μ B * (μ[B | A] * μ A)) := by ring
      _ = ((μ B)⁻¹ * μ B) * (μ[B | A] * μ A) := by ring
      _ = 1 * (μ[B | A] * μ A) := by
        rw [ENNReal.inv_mul_cancel (ne_of_gt hB_pos) (measure_ne_top μ B)]
      _ = μ[B | A] * μ A := by simp]
