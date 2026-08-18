-- Problema 27: Límite fundamental trigonométrico
-- lim_{x→0} sin(x)/x = 1

import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.Asymptotics.Lemmas

open Real Filter Asymptotics Topology in
theorem tendsto_sin_div_self :
    Tendsto (fun x => sin x / x) (𝓝[≠] 0) (𝓝 1) := by
  have h : (fun x : ℝ => sin x - x) =o[𝓝 0] (fun x : ℝ => x) := by
    have := (hasDerivAt_sin 0).isLittleO
    simpa [sin_zero, cos_zero, sub_zero, one_smul] using this
  have hdiv : Tendsto (fun x => (sin x - x) / x) (𝓝 0) (𝓝 0) :=
    h.tendsto_div_nhds_zero
  have hdiv' : Tendsto (fun x => (sin x - x) / x) (𝓝[≠] 0) (𝓝 0) :=
    hdiv.mono_left (nhdsWithin_le_nhds)
  have step1 : Tendsto (fun x => (sin x - x) / x + (1:ℝ)) (𝓝[≠] 0) (𝓝 (0 + 1)) :=
    Tendsto.add hdiv' (tendsto_const_nhds : Tendsto (fun _ => (1:ℝ)) _ _)
  simp only [zero_add] at step1
  have step2 : (fun x : ℝ => sin x / x) =ᶠ[𝓝[≠] 0] (fun x => (sin x - x) / x + 1) := by
    filter_upwards [self_mem_nhdsWithin] with x hx using by
      have hne : x ≠ 0 := hx
      calc sin x / x = (sin x - x + x) / x := by congr 1; ring
        _ = (sin x - x) / x + x / x := by rw [add_div]
        _ = (sin x - x) / x + 1 := by rw [div_self hne]
  exact Tendsto.congr' step2.symm step1
