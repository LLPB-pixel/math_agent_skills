-- Problema 71: Desigualdad de Chebyshev
-- P(|X - μ| ≥ kσ) ≤ 1/k²

import Mathlib.Probability.Moments.Variance

open MeasureTheory Filter Finset

open scoped MeasureTheory ProbabilityTheory ENNReal NNReal

/-- Forma general de la desigualdad de Chebyshev:
    Para X en L² y c > 0, P(|X - μ[X]| ≥ c) ≤ Var[X]/c².
    Demostración directa del teorema `meas_ge_le_variance_div_sq` de Mathlib. -/
theorem chebyshev_inequality_general
    {Ω : Type*} {mΩ : MeasurableSpace Ω} {μ : Measure Ω} [IsFiniteMeasure μ]
    {X : Ω → ℝ} (hX : MemLp X 2 μ)
    {c : ℝ} (hc : 0 < c) :
    μ {ω | c ≤ |X ω - μ[X]|} ≤ ENNReal.ofReal (Var[X; μ] / c ^ 2) :=
  ProbabilityTheory.meas_ge_le_variance_div_sq hX hc

/-- Forma especializada de la desigualdad de Chebyshev:
    Para X en L² con varianza positiva y k > 0,
    P(|X - μ| ≥ kσ) ≤ 1/k², donde σ = √Var[X].
    Se obtiene sustituyendo c = kσ en la forma general. -/
theorem chebyshev_inequality
    {Ω : Type*} {mΩ : MeasurableSpace Ω} {μ : Measure Ω} [IsProbabilityMeasure μ]
    {X : Ω → ℝ} (hX : MemLp X 2 μ) (hX_var : 0 < Var[X; μ])
    {k : ℝ} (hk : 0 < k) :
    μ {ω | k * √Var[X; μ] ≤ |X ω - μ[X]|} ≤ ENNReal.ofReal (1 / k ^ 2) := by
  have hk_pos : 0 < k := hk
  have hk_sq_pos : 0 < k ^ 2 := sq_pos_of_pos hk_pos
  have hvar_pos : 0 < Var[X; μ] := hX_var
  -- c = k * √Var[X]
  set c := k * √Var[X; μ] with hc_def
  have hc_pos : 0 < c := mul_pos hk_pos (Real.sqrt_pos.mpr hvar_pos)
  -- Aplicamos Chebyshev general
  have h_cheb := ProbabilityTheory.meas_ge_le_variance_div_sq hX hc_pos
  -- h_cheb : μ {ω | c ≤ |X ω - μ[X]|} ≤ ENNReal.ofReal (Var[X] / c²)
  -- Mostramos que c² = k² · Var[X]
  have hc_sq : c ^ 2 = k ^ 2 * Var[X; μ] := by
    rw [hc_def, mul_pow, Real.sq_sqrt (le_of_lt hvar_pos)]
  -- Var[X] / c² = Var[X] / (k² · Var[X]) = 1/k²
  have h_ratio : Var[X; μ] / c ^ 2 = 1 / k ^ 2 := by
    rw [hc_sq]
    have h_cancel : Var[X; μ] ≠ 0 := ne_of_gt hvar_pos
    have h_k2_cancel : k ^ 2 ≠ 0 := ne_of_gt hk_sq_pos
    field_simp
  rw [h_ratio] at h_cheb
  exact h_cheb
