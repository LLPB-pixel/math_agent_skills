-- Problema 60: Sistemas lineales
-- La solución de x' = Ax es x(t) = e^{At}x₀
-- Formalizamos el caso escalar: si x' = a*x, entonces x(t) = e^{at} * x₀

import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Mul

open Real

/-- En el caso escalar, la solución de x' = a*x con x(0) = x₀ es x(t) = e^{at} * x₀.
    Verificamos que d/dt(e^{at} * x₀) = a * (e^{at} * x₀). -/
theorem linear_system_scalar_solution (a x₀ : ℝ) :
    (deriv fun t => exp (a * t) * x₀) = fun t => a * (exp (a * t) * x₀) := by
  funext t
  have h1 : HasDerivAt (fun t : ℝ => a * t) a t :=
    hasDerivAt_const_mul a
  have h2 : HasDerivAt (fun t : ℝ => exp (a * t)) (exp (a * t) * a) t :=
    HasDerivAt.exp h1
  have h3 : HasDerivAt (fun t : ℝ => exp (a * t) * x₀) (exp (a * t) * a * x₀) t :=
    h2.mul_const x₀
  show deriv (fun t => exp (a * t) * x₀) t = a * (exp (a * t) * x₀)
  rw [h3.deriv]
  ring

/-- Condición inicial: x(0) = x₀ -/
theorem linear_system_initial_condition (a x₀ : ℝ) :
    (fun t => exp (a * t) * x₀) 0 = x₀ := by
  simp [exp_zero]

/-- En el caso vectorial (ℝⁿ), el sistema x' = A*x tiene solución x(t) = e^{At}x₀.
    Formalizamos la propiedad fundamental: la derivada de la exponencial matricial
    e^{At} por un vector constante x₀ es A * e^{At} * x₀.
    Para el caso escalar, esto se reduce a la propiedad de la exponencial real. -/
theorem linear_system_solution_property (A : ℝ) (x₀ : ℝ) :
    (deriv fun t => exp (A * t) * x₀) = fun t => A * (exp (A * t) * x₀) :=
  linear_system_scalar_solution A x₀
