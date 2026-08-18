-- Test 99: Teorema central del límite
-- La suma normalizada de variables iid converge a normal

import Mathlib.Probability.CentralLimitTheorem

open MeasureTheory ProbabilityTheory Filter
open scoped Real Topology

/-- **Teorema central del límite**: Dada una secuencia de variables aleatorias
    X : ℕ → Ω → ℝ independientes e idénticamente distribuidas, centradas
    con varianza 1, la secuencia n ↦ (√n)⁻¹ * ∑ k < n, X k converge
    en distribución a la normal estándar N(0,1). -/
theorem central_limit_theorem_iid
    {Ω Ω' : Type*} {mΩ : MeasurableSpace Ω} {mΩ' : MeasurableSpace Ω'}
    {P : Measure Ω} [IsProbabilityMeasure P]
    {P' : Measure Ω'} [IsProbabilityMeasure P']
    {X : ℕ → Ω → ℝ} {Y : Ω' → ℝ}
    (hY : HasLaw Y (gaussianReal 0 1) P')
    (h0 : P[X 0] = 0) (h1 : P[X 0 ^ 2] = 1)
    (hindep : iIndepFun X P)
    (hident : ∀ i, IdentDistrib (X i) (X 0) P P) :
    TendstoInDistribution
      (fun (n : ℕ) ω ↦ (√n)⁻¹ * ∑ k ∈ Finset.range n, X k ω)
      atTop Y (fun _ ↦ P) P' :=
  tendstoInDistribution_inv_sqrt_mul_sum hY h0 h1 hindep hident

/-- **Teorema central del límite (versión general)**: Dada una secuencia de
    variables aleatorias iid con media μ y varianza v ≠ 0, la secuencia
    normalizada converge en distribución a N(0, v). -/
theorem central_limit_theorem_general
    {Ω Ω' : Type*} {mΩ : MeasurableSpace Ω} {mΩ' : MeasurableSpace Ω'}
    {P : Measure Ω} [IsProbabilityMeasure P]
    {P' : Measure Ω'} [IsProbabilityMeasure P']
    {X : ℕ → Ω → ℝ} {Y : Ω' → ℝ}
    (hY : HasLaw Y (gaussianReal 0 Var[X 0; P].toNNReal) P')
    (hX : MemLp (X 0) 2 P) (hindep : iIndepFun X P)
    (hident : ∀ i, IdentDistrib (X i) (X 0) P P) :
    TendstoInDistribution
      (fun (n : ℕ) ω ↦ (√n)⁻¹ * (∑ k ∈ Finset.range n, X k ω - n * P[X 0]))
      atTop Y (fun _ ↦ P) P' :=
  tendstoInDistribution_inv_sqrt_mul_sum_sub hY hX hindep hident
