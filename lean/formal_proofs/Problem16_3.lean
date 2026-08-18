-- Test 74: Suma de normales independientes
-- Si X ~ N(mu1, sigma1) e Y ~ N(mu2, sigma2) son independientes,
-- entonces X + Y ~ N(mu1 + mu2, sigma1^2 + sigma2^2)

import Mathlib.Probability.Notation
import Mathlib.Probability.Distributions.Gaussian.HasGaussianLaw.Independence

open MeasureTheory ProbabilityTheory

/-- Suma de normales independientes: la suma de dos variables aleatorias
    con leyes gaussianas independientes tiene ley gaussiana -/
theorem sum_independent_normals
    {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} [IsProbabilityMeasure P]
    {X Y : Ω → ℝ} (hX : HasGaussianLaw X P) (hY : HasGaussianLaw Y P)
    (h : X ⟂ᵢ[P] Y) :
    HasGaussianLaw (fun ω => X ω + Y ω) P :=
  (h.hasGaussianLaw hX hY).fun_add
