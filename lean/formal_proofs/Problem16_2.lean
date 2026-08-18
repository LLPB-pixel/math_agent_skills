-- Test 73: Jensen para v.a. convexas
-- f(E[X]) <= E[f(X)] para f convexa

import Mathlib.Probability.Notation
import Mathlib.Analysis.Convex.Integral

open MeasureTheory ProbabilityTheory Filter

/-- Desigualdad de Jensen para variables aleatorias con función convexa:
    f(E[X]) <= E[f(X)] -/
theorem jensen_inequality
    {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X : Ω → ℝ} {f : ℝ → ℝ}
    (hf : ConvexOn ℝ Set.univ f)
    (hfc : ContinuousOn f Set.univ)
    (hX : Integrable X μ) (hfX : Integrable (f ∘ X) μ) :
    f (∫ ω, X ω ∂μ) ≤ ∫ ω, f (X ω) ∂μ := by
  have hsc : IsClosed (Set.univ : Set ℝ) := isClosed_univ
  have hfs : ∀ᵐ ω ∂μ, X ω ∈ (Set.univ : Set ℝ) := Eventually.of_forall fun _ => Set.mem_univ _
  exact hf.map_integral_le hfc hsc hfs hX hfX
