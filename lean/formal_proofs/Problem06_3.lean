-- Problema 28: Límite de (e^x - 1)/x
-- lim_{x→0} (e^x - 1)/x = 1

import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Asymptotics.Lemmas

open Real Filter Asymptotics Topology in
theorem tendsto_exp_sub_one_div :
    Tendsto (fun x => (Real.exp x - 1) / x) (𝓝[≠] 0) (𝓝 1) := by
  have h : (fun x : ℝ => Real.exp x - 1 - x) =o[𝓝 0] (fun x : ℝ => x) := by
    have := (hasDerivAt_exp 0).isLittleO
    simpa [Real.exp_zero, sub_zero, one_smul] using this
  have hdiv : Tendsto (fun x => (Real.exp x - 1 - x) / x) (𝓝 0) (𝓝 0) :=
    h.tendsto_div_nhds_zero
  have hdiv' : Tendsto (fun x => (Real.exp x - 1 - x) / x) (𝓝[≠] 0) (𝓝 0) :=
    hdiv.mono_left (nhdsWithin_le_nhds)
  have step1 : Tendsto (fun x => (Real.exp x - 1 - x) / x + (1:ℝ)) (𝓝[≠] 0) (𝓝 (0 + 1)) :=
    Tendsto.add hdiv' (tendsto_const_nhds : Tendsto (fun _ => (1:ℝ)) _ _)
  simp only [zero_add] at step1
  have step2 : (fun x : ℝ => (Real.exp x - 1) / x) =ᶠ[𝓝[≠] 0]
      (fun x => (Real.exp x - 1 - x) / x + 1) := by
    filter_upwards [self_mem_nhdsWithin] with x hx using by
      have hne : x ≠ 0 := hx
      calc (Real.exp x - 1) / x = (Real.exp x - 1 - x + x) / x := by ring_nf
        _ = (Real.exp x - 1 - x) / x + x / x := by rw [add_div]
        _ = (Real.exp x - 1 - x) / x + 1 := by rw [div_self hne]
  exact Tendsto.congr' step2.symm step1
