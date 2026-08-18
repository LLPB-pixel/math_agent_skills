-- Test 91: Teorema del punto fijo de Banach
-- Una contracción en un espacio métrico completo tiene un punto fijo único.

import Mathlib.Topology.MetricSpace.Contracting

open scoped NNReal

/-- Teorema del punto fijo de Banach: toda contracción en un espacio métrico
    completo y no vacío tiene exactamente un punto fijo. -/
theorem banach_fixed_point
    (α : Type*) [MetricSpace α] [CompleteSpace α] [Nonempty α]
    (K : ℝ≥0) (f : α → α) (hf : ContractingWith K f) :
    ∃ x : α, f x = x ∧ ∀ y : α, f y = y → x = y := by
  refine ⟨hf.fixedPoint f, hf.fixedPoint_isFixedPt, ?_⟩
  intro y hy
  exact (hf.fixedPoint_unique hy).symm
