-- Problema 62: Probabilidad de la unión
-- P(A ∪ B) + P(A ∩ B) = P(A) + P(B)

import Mathlib.MeasureTheory.Measure.Typeclasses.Probability

open MeasureTheory

set_option linter.unusedSectionVars false in
set_option linter.unusedVariables false in

/-- Inclusión-exclusión para medida de probabilidad -/
theorem prob_union_inclusion_exclusion {Ω : Type*} [MeasurableSpace Ω]
    {μ : Measure Ω} [IsProbabilityMeasure μ]
    {A B : Set Ω} (hA : MeasurableSet A) (hB : MeasurableSet B) :
    μ (A ∪ B) + μ (A ∩ B) = μ A + μ B :=
  measure_union_add_inter A hB
