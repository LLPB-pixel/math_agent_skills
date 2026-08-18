-- Problema 63: Independencia
-- Si A, B independientes entonces P(A ∩ B) = P(A) * P(B)

import Mathlib.MeasureTheory.Measure.Typeclasses.Probability

open MeasureTheory

/-- Independencia de eventos: P(A ∩ B) = P(A) * P(B) -/
def IndependentEvents {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) (A B : Set Ω) : Prop :=
  μ (A ∩ B) = μ A * μ B

/-- Si A, B son independientes, entonces P(A ∩ B) = P(A) * P(B) -/
theorem independent_implies_intersection {Ω : Type*} [MeasurableSpace Ω]
    {μ : Measure Ω} {A B : Set Ω} (h : IndependentEvents μ A B) :
    μ (A ∩ B) = μ A * μ B :=
  h
