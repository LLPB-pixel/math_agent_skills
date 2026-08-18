-- Test 78: EMV de mu en normal - La media muestral es el estimador de maxima verosimilitud

import Mathlib.Probability.Moments.Variance
import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic

open MeasureTheory ProbabilityTheory Finset
open scoped ProbabilityTheory

noncomputable section

/-- La condicion de optimalidad del EMV para mu en N(mu, sigma^2):
    La derivada del log-verosimilitud respecto a mu se anula cuando mu = X-barra.
    Esto equivale a sum_i (x_i - mu_hat) = 0 donde mu_hat = media muestral. -/
theorem mle_score_normal (n : Nat) (hn : 0 < n)
    (sigma2 : Real) (hsigma2 : 0 < sigma2)
    (observations : Fin n -> Real) :
    Finset.sum Finset.univ (fun i =>
      observations i - (1 / (n : Real)) * Finset.sum Finset.univ (fun j => observations j)) = 0 := by
  simp only [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_fin, nsmul_eq_mul]
  field_simp
  ring
