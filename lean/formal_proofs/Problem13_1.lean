-- Problema 57: Ecuación diferencial exponencial
-- La solución de y' = ky es y(t) = y₀ e^{kt} con y(0) = y₀

import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Mul

open Real

/-- La función y(t) = y₀ * exp(k * t) satisface la EDO y' = k * y -/
theorem exponential_ode_solution (y₀ k : ℝ) :
    (deriv fun t => y₀ * exp (k * t)) = fun t => k * (y₀ * exp (k * t)) := by
  funext t
  have h1 : HasDerivAt (fun t : ℝ => k * t) k t :=
    hasDerivAt_const_mul k
  have h2 : HasDerivAt (fun t : ℝ => exp (k * t)) (exp (k * t) * k) t :=
    HasDerivAt.exp h1
  have h3 : HasDerivAt (fun t : ℝ => y₀ * exp (k * t)) (y₀ * (exp (k * t) * k)) t :=
    h2.const_mul y₀
  show deriv (fun t => y₀ * exp (k * t)) t = k * (y₀ * exp (k * t))
  rw [h3.deriv]
  ring

/-- Condición inicial: y(0) = y₀ -/
theorem exponential_ode_initial_condition (y₀ k : ℝ) :
    (fun t => y₀ * exp (k * t)) 0 = y₀ := by
  simp [exp_zero]
