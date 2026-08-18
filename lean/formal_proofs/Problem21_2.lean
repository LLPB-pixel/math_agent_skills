-- Test 97: Teorema de Radon-Nikodym
-- Derivada de medida absolutamente continua: si μ ≪ ν, existe f tal que μ = f·ν

import Mathlib.MeasureTheory.Measure.Decomposition.RadonNikodym

open MeasureTheory

/-- **Teorema de Radon-Nikodym**: Si μ es absolutamente continua respecto a ν
    y existe descomposición de Lebesgue, entonces μ = ν.withDensity (rnDeriv μ ν). -/
theorem radon_nikodym_theorem
    {α : Type*} {m : MeasurableSpace α}
    {μ ν : Measure α} [μ.HaveLebesgueDecomposition ν] :
    μ ≪ ν ↔ ν.withDensity (μ.rnDeriv ν) = μ :=
  Measure.absolutelyContinuous_iff_withDensity_rnDeriv_eq

/-- Si μ ≪ ν, entonces la integral de la derivada Radon-Nikodym sobre cualquier
    conjunto medible recupera la medida μ. -/
theorem radon_nikodym_integral
    {α : Type*} {m : MeasurableSpace α}
    {μ ν : Measure α} [μ.HaveLebesgueDecomposition ν] [SFinite ν]
    (hμν : μ ≪ ν) (s : Set α) :
    ∫⁻ x in s, μ.rnDeriv ν x ∂ν = μ s :=
  Measure.setLIntegral_rnDeriv hμν s

/-- La integral de la derivada Radon-Nikodym sobre todo el espacio
    recupera la medida total de μ. -/
theorem radon_nikodym_total_integral
    {α : Type*} {m : MeasurableSpace α}
    {μ ν : Measure α} [μ.HaveLebesgueDecomposition ν] [SFinite ν]
    (hμν : μ ≪ ν) :
    ∫⁻ x, μ.rnDeriv ν x ∂ν = μ Set.univ :=
  Measure.lintegral_rnDeriv hμν
