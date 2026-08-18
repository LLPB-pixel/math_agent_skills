-- Problema 65: Probabilidad total
-- P(A) = Σᵢ P(A|Bᵢ) * P(Bᵢ)

import Mathlib.Probability.ConditionalProbability

open MeasureTheory ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsFiniteMeasure μ]

/-- Ley de la probabilidad total para variable aleatoria con valores en fintype -/
theorem total_probability {α : Type*} [Fintype α] [MeasurableSpace α]
    [DiscreteMeasurableSpace α] {X : Ω → α} (hX : Measurable X) :
    ∑ x, μ (X ⁻¹' {x}) • μ[|X ← x] = μ :=
  sum_meas_smul_cond_fiber hX μ
