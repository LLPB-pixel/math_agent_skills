-- Test 72: Cauchy-Schwarz
-- (E[XY])^2 <= E[X^2] * E[Y^2]

import Mathlib.Probability.Notation
import Mathlib.Probability.Moments.Variance

open MeasureTheory ProbabilityTheory

/-- Desigualdad de Cauchy-Schwarz para expectativas: (E[XY])^2 <= E[X^2] * E[Y^2] -/
theorem cauchy_schwarz_expectation
    {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ}
    (hX : MemLp X 2 μ) (hY : MemLp Y 2 μ) :
    (μ[X * Y]) ^ 2 ≤ μ[X ^ 2] * μ[Y ^ 2] := by
  have hXY : Integrable (X * Y) μ := MemLp.integrable_mul hX hY
  have hX2 : Integrable (X ^ 2) μ := hX.integrable_sq
  have hY2 : Integrable (Y ^ 2) μ := hY.integrable_sq
  -- The key: for all t, E[(tX + Y)^2] >= 0
  -- which expands to t^2*E[X^2] + 2t*E[XY] + E[Y^2] >= 0
  have h_exp : ∀ t : ℝ,
      (∫ ω, X ω ^ 2 ∂μ) * (t * t) +
      (2 * ∫ ω, X ω * Y ω ∂μ) * t +
      (∫ ω, Y ω ^ 2 ∂μ) ≥ 0 := by
    intro t
    have h_sq : ∀ ω, (t * X ω + Y ω) ^ 2 =
        t * t * (X ω ^ 2) + (2 * t) * (X ω * Y ω) + Y ω ^ 2 := fun ω => by ring
    have h_nonneg : 0 ≤ ∫ ω, (t * X ω + Y ω) ^ 2 ∂μ :=
      integral_nonneg (fun ω => sq_nonneg _)
    have h_eq := integral_congr_ae (ae_of_all μ h_sq)
    rw [h_eq] at h_nonneg
    -- Now use the specific forms to split the integral
    have h₁ := integral_add' (μ := μ) (f := fun ω => t * t * X ω ^ 2) (g := fun ω => 2 * t * (X ω * Y ω) + Y ω ^ 2)
    sorry
  sorry
