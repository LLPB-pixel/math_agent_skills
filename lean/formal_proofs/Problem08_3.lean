-- Problema 8.3: Derivada nula implica constante
-- Si f'(x) = 0 en intervalo, f es constante

import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-- **Derivada nula implica constante**: Si f es diferenciable en ℝ y f'(x) = 0 para todo x,
    entonces f es constante. -/
theorem const_of_deriv_zero {f : ℝ → ℝ}
    (hf : Differentiable ℝ f) (hf' : ∀ x, deriv f x = 0) :
    ∃ c : ℝ, ∀ x, f x = c := by
  use f 0
  intro x
  have h_mono : Monotone f :=
    monotone_of_deriv_nonneg hf (fun y => by simp [hf' y])
  have h_anti : Antitone f :=
    antitone_of_deriv_nonpos hf (fun y => by simp [hf' y])
  by_cases h : 0 ≤ x
  · exact le_antisymm (h_anti h) (h_mono h)
  · have hx : x ≤ 0 := le_of_lt (not_le.mp h)
    exact le_antisymm (h_mono hx) (h_anti hx)
