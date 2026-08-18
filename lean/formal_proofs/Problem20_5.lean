-- Test 95: Convergencia dominada de Lebesgue
-- El límite de integrales de una sucesión dominada converge a la integral del límite.

import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Analysis.Normed.Group.Tannery

open MeasureTheory Filter Topology
open scoped Topology

/-- Teorema de convergencia dominada de Lebesgue (versión Tannery): si una sucesión
    de funciones fₙ converge puntualmente a f, y ‖fₙ‖ ≤ bound donde bound es summable,
    entonces la serie ∑' fₙ converge a ∑' f. -/
theorem dominated_convergence_tannery
    {α β G : Type*} {𝓕 : Filter α}
    [NormedAddCommGroup G] [CompleteSpace G]
    {f : α → β → G} {g : β → G} {bound : β → ℝ}
    (h_sum : Summable bound)
    (hab : ∀ k : β, Tendsto (f · k) 𝓕 (𝓝 (g k)))
    (h_bound : ∀ᶠ n in 𝓕, ∀ k, ‖f n k‖ ≤ bound k) :
    Tendsto (∑' k, f · k) 𝓕 (𝓝 (∑' k, g k)) :=
  tendsto_tsum_of_dominated_convergence h_sum hab h_bound

/-- Teorema de convergencia dominada de Lebesgue (versión integral Bochner):
    si Fₙ converge c.t.p. a f, y ‖Fₙ‖ ≤ bound con bound integrable,
    entonces ∫ Fₙ converge a ∫ f. -/
theorem dominated_convergence_integral
    {α G : Type*} [MeasurableSpace α] {μ : Measure α}
    [NormedAddCommGroup G] [NormedSpace ℝ G]
    {F : ℕ → α → G} {f : α → G} {bound : α → ℝ}
    (F_measurable : ∀ n, AEStronglyMeasurable (F n) μ)
    (bound_integrable : Integrable bound μ)
    (h_bound : ∀ n, ∀ᵐ a ∂μ, ‖F n a‖ ≤ bound a)
    (h_lim : ∀ᵐ a ∂μ, Tendsto (fun n => F n a) atTop (𝓝 (f a))) :
    Tendsto (fun n => ∫ a, F n a ∂μ) atTop (𝓝 <| ∫ a, f a ∂μ) :=
  tendsto_integral_of_dominated_convergence bound F_measurable bound_integrable h_bound h_lim
