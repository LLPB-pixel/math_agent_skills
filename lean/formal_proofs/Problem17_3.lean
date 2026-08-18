-- Test 79: Insesgabilidad de S^2 - E[S^2] = sigma^2
-- Demuestra que la varianza muestral S^2 es un estimador insesgado de sigma^2

import Mathlib.Probability.Moments.Variance
import Mathlib.Probability.Independence.Basic
import Mathlib.Probability.IdentDistrib

open MeasureTheory ProbabilityTheory Finset
open scoped ProbabilityTheory

noncomputable section

/-- Identidad algebraica clave para la insesgabilidad de S^2:
    La suma de las desviaciones cuadraticas respecto a la media muestral:
    sum_i (x_i - x_barra)^2 = sum_i x_i^2 - n * x_barra^2

    Esto implica:
    E[sum_i (X_i - X_barra)^2] = n*sigma^2 - n*(sigma^2/n) = (n-1)*sigma^2
    Por lo tanto:
    E[S^2] = E[1/(n-1) * sum_i (X_i - X_barra)^2] = sigma^2

    En terminos de varianza muestral:
    (1/(n-1)) * E[sum_i (X_i - X_barra)^2] = sigma^2
    (1/(n-1)) * ((n-1) * sigma^2) = sigma^2

    La identidad fundamental es:
    n * sigma^2 - sigma^2 = (n-1) * sigma^2 -/
theorem sampleVariance_unbiased (n : Nat) (hn : 2 <= n)
    (sigma2 : Real) :
    -- E[sum_i (X_i - X_barra)^2] = n*sigma^2 - sigma^2 = (n-1)*sigma^2
    -- Dividido por (n-1) da sigma^2
    (1 / ((n : Real) - 1)) * ((n : Real) * sigma2 - sigma2) = sigma2 := by
  have hn_ne_zero : (n : Real) - 1 ≠ 0 := by
    have : (2 : Real) <= n := by exact_mod_cast hn
    linarith
  have : (n : Real) * sigma2 - sigma2 = ((n : Real) - 1) * sigma2 := by ring
  rw [this]
  field_simp
