-- Test 76: Insesgabilidad de X_bar
-- E[X_bar] = mu

import Mathlib.Probability.Notation

open MeasureTheory ProbabilityTheory

/-- Linealidad de la integral sobre una suma finita -/
theorem integral_finset_sum_div
    {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    {X : ℕ → Ω → ℝ} (hX : ∀ i, Integrable (X i) μ) (n : ℕ) (_ : 0 < n) :
    ∫ ω, (Finset.sum (Finset.range n) (fun i => X i ω)) / (n : ℝ) ∂μ =
    Finset.sum (Finset.range n) (fun i => ∫ ω, X i ω ∂μ) / (n : ℝ) := by
  have hsum : Integrable (fun ω => Finset.sum (Finset.range n) (fun i => X i ω)) μ :=
    integrable_finsetSum _ (fun i _ => hX i)
  rw [integral_div (n : ℝ) (fun ω => Finset.sum (Finset.range n) (fun i => X i ω))]
  congr 1
  exact integral_finsetSum (Finset.range n) (fun i _ => hX i)

/-- Insesgabilidad de la media muestral: E[X_bar] = mu -/
theorem sample_mean_unbiased
    {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X : ℕ → Ω → ℝ} (hX : ∀ i, Integrable (X i) μ) (n : ℕ) (hn : 0 < n)
    (hmean : ∀ i, ∫ ω, X i ω ∂μ = c) :
    ∫ ω, (Finset.sum (Finset.range n) (fun i => X i ω)) / (n : ℝ) ∂μ = c := by
  rw [integral_finset_sum_div hX n hn, Finset.sum_congr rfl (fun i _ => by rw [hmean i]),
    Finset.sum_const, Finset.card_range, nsmul_eq_mul]
  field_simp [show (n : ℝ) ≠ 0 from Nat.cast_ne_zero.mpr hn.ne']
