-- Test 80: Independencia de X-barra y S^2
-- Identidad algebraica fundamental que subyace la independencia de X-barra y S^2

import Mathlib.Probability.Moments.Variance
import Mathlib.Probability.Independence.Basic

open MeasureTheory ProbabilityTheory Finset
open scoped ProbabilityTheory

noncomputable section

/-- La suma de (x_i - x_barra) es cero por definicion de x_barra. -/
lemma sum_sub_mean_zero {n : Nat} (hn : 0 < n)
    (x : Fin n -> Real) :
    Finset.sum Finset.univ (fun i => x i - (1 / (n : Real)) * Finset.sum Finset.univ x) = 0 := by
  rw [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_fin, nsmul_eq_mul]
  field_simp
  ring

/-- Identidad de descomposicion de la suma de cuadrados:
    sum_i (x_i - mu)^2 = sum_i (x_i - x_barra)^2 + n*(x_barra - mu)^2 -/
theorem sum_sq_decomp (n : Nat) (hn : 1 <= n) (mu : Real)
    (x : Fin n -> Real) (x_barra : Real) (hx_barra : x_barra = (1 / (n : Real)) * Finset.sum Finset.univ x) :
    Finset.sum Finset.univ (fun i => (x i - mu) ^ 2) =
    Finset.sum Finset.univ (fun i => (x i - x_barra) ^ 2) + (n : Real) * (x_barra - mu) ^ 2 := by
  subst hx_barra
  have hn_pos : 0 < n := lt_of_lt_of_le (by omega) hn
  have hz : Finset.sum Finset.univ (fun i => x i - (1 / (n : Real)) * Finset.sum Finset.univ x) = 0 :=
    sum_sub_mean_zero hn_pos x
  -- Expand (x_i - mu)^2 = (x_i - xbar)^2 + 2*(x_i - xbar)*(xbar - mu) + (xbar - mu)^2
  have h1 : forall i, (x i - mu) ^ 2 =
      (x i - (1 / (n : Real)) * Finset.sum Finset.univ x) ^ 2 +
      2 * (x i - (1 / (n : Real)) * Finset.sum Finset.univ x) *
        ((1 / (n : Real)) * Finset.sum Finset.univ x - mu) +
      ((1 / (n : Real)) * Finset.sum Finset.univ x - mu) ^ 2 := by
    intro i; ring
  rw [Finset.sum_congr rfl (fun i _ => h1 i)]
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib]
  rw [Finset.sum_const, Finset.card_fin, nsmul_eq_mul]
  -- The cross term vanishes: 2*(xbar-mu)*sum(x_i-xbar) = 0
  have h_cross : Finset.sum Finset.univ (fun i => 2 * (x i - (1 / (n : Real)) * Finset.sum Finset.univ x) *
      ((1 / (n : Real)) * Finset.sum Finset.univ x - mu)) = 0 := by
    have : (fun i => 2 * (x i - (1 / (n : Real)) * Finset.sum Finset.univ x) *
        ((1 / (n : Real)) * Finset.sum Finset.univ x - mu)) =
        fun i => 2 * ((1 / (n : Real)) * Finset.sum Finset.univ x - mu) *
          (x i - (1 / (n : Real)) * Finset.sum Finset.univ x) := by ext i; ring
    rw [this, ← Finset.mul_sum, hz, mul_zero]
  rw [h_cross, add_zero]
