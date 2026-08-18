-- Test 77: Varianza de la media muestral = sigma^2/n
-- Demuestra que Var(X-barra) = sigma^2/n para variables iid

import Mathlib.Probability.Moments.Variance
import Mathlib.Probability.Independence.Basic

open MeasureTheory ProbabilityTheory Finset
open scoped ProbabilityTheory

noncomputable section

/-- La varianza de la media muestral de n variables iid es sigma^2/n.
    Usa linealidad de la varianza y la independencia. -/
theorem variance_sample_mean {Omega : Type*} {mOmega : MeasurableSpace Omega}
    {mu : Measure Omega} [IsProbabilityMeasure mu] {n : Nat} (hn : 0 < n)
    (X : Fin n -> Omega -> Real)
    (hX : forall i, MemLp (X i) 2 mu)
    (h_indep : forall i j, i != j -> IndepFun (X i) (X j) mu) :
    Var[fun omega => (1 / (n : Real)) * Finset.sum Finset.univ (fun i => X i omega); mu] =
    (1 / (n : Real) ^ 2) * Finset.sum Finset.univ (fun i => Var[X i; mu]) := by
  have h_var_mul := variance_const_mul (1 / (n : Real))
    (fun omega => Finset.sum Finset.univ (fun i => X i omega)) mu
  rw [h_var_mul]
  have h_var_sum : Var[Finset.sum Finset.univ X; mu] =
      Finset.sum Finset.univ (fun i => Var[X i; mu]) := by
    rw [IndepFun.variance_sum]
    · intro i _
      exact hX i
    · intro i _ j _ hij
      exact h_indep i j (bne_iff_ne.mpr hij)
  have h_eta : Var[fun omega => Finset.sum Finset.univ (fun i => X i omega); mu] =
      Var[Finset.sum Finset.univ X; mu] := by
    congr 1
    ext omega
    exact (Finset.sum_apply _ _ _).symm
  rw [h_eta, h_var_sum]
  -- Remaining: (1/n)^2 * sum = 1/n^2 * sum
  congr 1
  field_simp
