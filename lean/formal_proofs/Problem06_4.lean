-- Problema 29: Límite de ln(1 + x)/x
-- lim_{x→0} ln(1 + x)/x = 1

import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Asymptotics.Lemmas

open Real Filter Asymptotics Topology in
theorem tendsto_log_one_add_div :
    Tendsto (fun x => Real.log (1 + x) / x) (𝓝[≠] 0) (𝓝 1) := by
  have h₀ : HasDerivAt (fun x => Real.log (1 + x)) (1 : ℝ) 0 := by
    have hf : HasDerivAt Real.log (1:ℝ)⁻¹ (1 + (0:ℝ)) := by
      rw [add_zero]
      exact hasDerivAt_log (by norm_num : (1:ℝ) ≠ 0)
    have hcomp := HasDerivAt.comp_const_add (1:ℝ) (0:ℝ) hf
    simp only [inv_one] at hcomp
    exact hcomp
  have h : (fun x : ℝ => Real.log (1 + x) - x) =o[𝓝 0] (fun x : ℝ => x) := by
    have := h₀.isLittleO
    simpa [add_zero, Real.log_one, sub_zero, one_smul] using this
  have hdiv : Tendsto (fun x => (Real.log (1 + x) - x) / x) (𝓝 0) (𝓝 0) :=
    h.tendsto_div_nhds_zero
  have hdiv' : Tendsto (fun x => (Real.log (1 + x) - x) / x) (𝓝[≠] 0) (𝓝 0) :=
    hdiv.mono_left (nhdsWithin_le_nhds)
  have step1 : Tendsto (fun x => (Real.log (1 + x) - x) / x + (1:ℝ)) (𝓝[≠] 0) (𝓝 (0 + 1)) :=
    Tendsto.add hdiv' (tendsto_const_nhds : Tendsto (fun _ => (1:ℝ)) _ _)
  simp only [zero_add] at step1
  have step2 : (fun x : ℝ => Real.log (1 + x) / x) =ᶠ[𝓝[≠] 0]
      (fun x => (Real.log (1 + x) - x) / x + 1) := by
    filter_upwards [self_mem_nhdsWithin] with x hx using by
      have hne : x ≠ 0 := hx
      calc Real.log (1 + x) / x = (Real.log (1 + x) - x + x) / x := by ring_nf
        _ = (Real.log (1 + x) - x) / x + x / x := by rw [add_div]
        _ = (Real.log (1 + x) - x) / x + 1 := by rw [div_self hne]
  exact Tendsto.congr' step2.symm step1
