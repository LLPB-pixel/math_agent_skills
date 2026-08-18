-- Problema 58: EDO afín
-- La solución de y' = ay + b es y(t) = Ce^{at} - b/a
-- Verificamos que y(t) = Ce^{at} - b/a satisface y' = a*y + b cuando a ≠ 0

import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add

open Real

/-- La función y(t) = C * exp(a * t) - b/a satisface la EDO y' = a * y + b
    cuando a ≠ 0 -/
theorem affine_ode_solution (C a b : ℝ) (ha : a ≠ 0) :
    (deriv fun t => C * exp (a * t) - b / a) =
    fun t => a * (C * exp (a * t) - b / a) + b := by
  funext t
  have h1 : HasDerivAt (fun t : ℝ => a * t) a t :=
    hasDerivAt_const_mul a
  have h2 : HasDerivAt (fun t : ℝ => exp (a * t)) (exp (a * t) * a) t :=
    HasDerivAt.exp h1
  have h3 : HasDerivAt (fun t : ℝ => C * exp (a * t)) (C * (exp (a * t) * a)) t :=
    h2.const_mul C
  have h4 : HasDerivAt (fun t : ℝ => C * exp (a * t) - b / a)
      (C * (exp (a * t) * a) - 0) t :=
    h3.sub (hasDerivAt_const t (b / a))
  show deriv (fun t => C * exp (a * t) - b / a) t =
    a * (C * exp (a * t) - b / a) + b
  rw [h4.deriv]
  field_simp
  ring

/-- Condición inicial: y(0) = C - b/a -/
theorem affine_ode_initial_condition (C a b : ℝ) (_ha : a ≠ 0) :
    (fun t => C * exp (a * t) - b / a) 0 = C - b / a := by
  simp [exp_zero]
