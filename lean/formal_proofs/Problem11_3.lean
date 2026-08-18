-- Problema 53: Teorema de Heine-Borel en ℝ
-- Cerrado y acotado ↔ compacto en ℝ (y en ℝⁿ)

import Mathlib.Topology.MetricSpace.Bounded

open Bornology

/-- Heine-Borel theorem for ℝ: a set is compact if and only if it is closed and bounded. -/
theorem heine_borel_real {s : Set ℝ} :
    IsCompact s ↔ IsClosed s ∧ IsBounded s :=
  Metric.isCompact_iff_isClosed_bounded
