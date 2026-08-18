-- Test 75: Media de normales independientes
-- Si X_i ~ N(mu, sigma^2) son iid, entonces X_bar ~ gaussiana

import Mathlib.Probability.Notation
import Mathlib.Probability.Distributions.Gaussian.HasGaussianLaw.Independence

open MeasureTheory ProbabilityTheory

/-- Suma de normales independientes: la suma finita de variables gaussianas
    independientes con la misma ley tiene ley gaussiana -/
theorem sum_independent_gaussians
    {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} [IsProbabilityMeasure P]
    {n : ℕ} {X : Fin n → Ω → ℝ}
    (hX : ∀ i, HasGaussianLaw (X i) P) (hInd : iIndepFun X P) :
    HasGaussianLaw (fun ω => ∑ i, X i ω) P :=
  hInd.hasGaussianLaw_fun_sum hX

/-- Media de normales independientes: la media de variables gaussianas independientes
    con la misma ley es gaussiana -/
theorem mean_independent_normals
    {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} [IsProbabilityMeasure P]
    {n : ℕ} {X : Fin n → Ω → ℝ}
    (hX : ∀ i, HasGaussianLaw (X i) P) (hInd : iIndepFun X P) (hn : 0 < n) :
    HasGaussianLaw (fun ω => (∑ i, X i ω) / (n : ℝ)) P := by
  have hsum := hInd.hasGaussianLaw_fun_sum hX
  have h_smul := hsum.smul (n : ℝ)⁻¹
  apply HasGaussianLaw.congr h_smul
  filter_upwards with ω
  show (↑n)⁻¹ * ∑ i, X i ω = (∑ i, X i ω) / ↑n
  rw [div_eq_mul_inv, mul_comm]
