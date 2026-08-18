-- Problema 61: Estabilidad asintótica
-- Autovalores con parte real negativa implica estabilidad asintótica
-- Formalizamos el caso escalar: si a < 0, entonces e^{at} → 0 cuando t → ∞

import Mathlib.Analysis.SpecialFunctions.Exp

open Real Filter Topology

/-- En el caso escalar, si a < 0, entonces la solución x(t) = e^{at}x₀ tiende a 0
    cuando t → ∞ (estabilidad asintótica del origen). -/
theorem asymptotic_stability_scalar (a : ℝ) (ha : a < 0) (x₀ : ℝ) :
    Tendsto (fun t => exp (a * t) * x₀) atTop (𝓝 0) := by
  have h1 : Tendsto (fun t => a * t) atTop atBot :=
    (tendsto_const_mul_atBot_of_neg ha).mpr tendsto_id
  have h2 : Tendsto (fun t => exp (a * t)) atTop (𝓝 0) :=
    tendsto_exp_atBot.comp h1
  have h3 : Tendsto (fun t => exp (a * t) * x₀) atTop (𝓝 (0 * x₀)) :=
    Tendsto.mul_const x₀ h2
  simpa using h3

/-- Estabilidad asintótica: si a < 0, todas las soluciones de x' = a*x convergen al origen -/
theorem asymptotic_stability_all_solutions (a : ℝ) (ha : a < 0) :
    ∀ x₀ : ℝ, Tendsto (fun t => exp (a * t) * x₀) atTop (𝓝 0) :=
  fun x₀ => asymptotic_stability_scalar a ha x₀
