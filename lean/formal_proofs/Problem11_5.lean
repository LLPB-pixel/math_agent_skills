-- Problema 55: Serie geométrica
-- ∑_{n=0}^{∞} rⁿ = 1/(1-r) para |r| < 1

import Mathlib.Analysis.SpecificLimits.Normed

/-- The geometric series ∑ rⁿ converges to 1/(1-r) when |r| < 1. -/
theorem geometric_series {r : ℝ} (h : |r| < 1) :
    HasSum (fun n : ℕ => r ^ n) (1 - r)⁻¹ :=
  hasSum_geometric_of_abs_lt_one h
