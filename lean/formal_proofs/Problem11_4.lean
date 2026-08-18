-- Problema 54: Convergencia absoluta implica convergencia
-- Si ∑|aₙ| converge, entonces ∑aₙ converge

import Mathlib.Data.Real.Basic
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Topology.Algebra.Ring.Real
import Mathlib.Topology.Algebra.InfiniteSum.Order

/-- Absolute convergence implies convergence: if ∑|f n| converges, then ∑f n converges. -/
theorem absolute_convergence_implies_convergence {ι : Type*}
    {f : ι → ℝ} (h : Summable fun n => |f n|) :
    Summable f :=
  Summable.of_abs h
