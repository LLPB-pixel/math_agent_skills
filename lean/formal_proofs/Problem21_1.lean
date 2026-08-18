-- Test 96: Teorema de Fubini
-- Integrales iteradas = integral múltiple sobre producto de medidas

import Mathlib.MeasureTheory.Integral.Prod

open MeasureTheory

/-- **Teorema de Fubini**: Para una función integrable f sobre un producto de medidas,
    la integral sobre el producto es igual a la integral iterada.
    Demostración directa del teorema `integral_prod` de Mathlib. -/
theorem fubini_theorem
    {α β : Type*} {mα : MeasurableSpace α} {mβ : MeasurableSpace β}
    {μ : Measure α} {ν : Measure β} [SFinite μ] [SFinite ν]
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {f : α × β → E} (hf : Integrable f (μ.prod ν)) :
    ∫ z, f z ∂μ.prod ν = ∫ x, ∫ y, f (x, y) ∂ν ∂μ :=
  integral_prod f hf

/-- **Teorema de Fubini (versión simétrica)**: La integral iterada en el otro orden
    también es igual a la integral sobre el producto. -/
theorem fubini_theorem_symm
    {α β : Type*} {mα : MeasurableSpace α} {mβ : MeasurableSpace β}
    {μ : Measure α} {ν : Measure β} [SFinite μ] [SFinite ν]
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {f : α × β → E} (hf : Integrable f (μ.prod ν)) :
    ∫ z, f z ∂μ.prod ν = ∫ y, ∫ x, f (x, y) ∂μ ∂ν :=
  integral_prod_symm f hf
