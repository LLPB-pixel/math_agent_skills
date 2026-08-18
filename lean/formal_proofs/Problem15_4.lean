-- Problema 70: Desigualdad de Markov
-- P(X ≥ a) ≤ E[X]/a  (para a > 0 y X no negativa)

import Mathlib.MeasureTheory.Integral.Bochner.Basic

open MeasureTheory Filter Finset

open scoped MeasureTheory ProbabilityTheory ENNReal NNReal

/-- Desigualdad de Markov: para X no negativa y a > 0, P(X ≥ a) ≤ E[X]/a.
    Se demuestra a partir de `mul_meas_ge_le_integral_of_nonneg` de Mathlib,
    que establece: ε · μ.real {x | ε ≤ f x} ≤ ∫ x, f x ∂μ.
    Con f = X y ε = a, obtenemos: a · P(X ≥ a) ≤ E[X], luego P(X ≥ a) ≤ E[X]/a. -/
theorem markov_inequality
    {Ω : Type*} {mΩ : MeasurableSpace Ω} {μ : Measure Ω}
    {X : Ω → ℝ} (_hX : AEStronglyMeasurable X μ)
    (hX_nonneg : 0 ≤ᵐ[μ] X) (hX_int : Integrable X μ)
    {a : ℝ} (ha : 0 < a) :
    μ.real {ω | a ≤ X ω} ≤ (∫ ω, X ω ∂μ) / a := by
  have ha_pos : 0 < a := ha
  have ha_ne : a ≠ 0 := ne_of_gt ha_pos
  -- Aplicamos la desigualdad de Markov de Mathlib
  have h_markov := mul_meas_ge_le_integral_of_nonneg hX_nonneg hX_int a
  -- h_markov : a * μ.real {ω | a ≤ X ω} ≤ ∫ ω, X ω ∂μ
  -- Reorganizamos: μ.real {ω | a ≤ X ω} ≤ (∫ ω, X ω ∂μ) / a
  have h_le : a * μ.real {ω | a ≤ X ω} ≤ ∫ ω, X ω ∂μ := h_markov
  -- De a * μ.real {ω | a ≤ X ω} ≤ ∫ ω, X ω ∂μ
  -- derivamos μ.real {ω | a ≤ X ω} ≤ (∫ ω, X ω ∂μ) / a
  rw [le_div_iff₀' ha_pos]
  exact h_markov
