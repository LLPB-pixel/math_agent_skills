-- Problema 11: Autovalores de matrices simétricas
-- Demuestra que una matriz real simétrica tiene autovalores reales
--
-- Demostración: Sea A simétrica, λ autovalor, v autovector:
-- λ̄‖v‖² = (λv)*·v = (Av)*·v = v·Aᵀv = v·Av = λ‖v‖²
-- Por lo tanto λ̄ = λ, es decir, λ ∈ ℝ
--
-- En Mathlib, `LinearMap.IsSymmetric.conj_eigenvalue_eq_self` establece
-- que los autovalores de un operador simétrico son reales.

import Mathlib.Analysis.InnerProductSpace.Spectrum

-- El resultado: para un operador simétrico T sobre un espacio de Hilbert ℂ,
-- si μ es autovalor, entonces μ es real (conj(μ) = μ)
open scoped ComplexConjugate in
theorem autovalores_simetricos_reales
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]
    (T : E →ₗ[ℂ] E) (hT : T.IsSymmetric) {μ : ℂ} (hμ : Module.End.HasEigenvalue T μ) :
    conj μ = μ :=
  hT.conj_eigenvalue_eq_self hμ
