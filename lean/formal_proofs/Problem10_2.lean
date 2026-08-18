-- Problema 47: ℚ no es completo
-- Existe sucesión de Cauchy en ℚ que no converge en ℚ

import Mathlib.Topology.MetricSpace.Cauchy
import Mathlib.NumberTheory.Real.Irrational

open Filter Bornology
open scoped Topology

/-- A Cauchy sequence in ℚ converging to √2 in ℝ does not converge in ℚ. -/
theorem Q_not_complete : ∃ u : ℕ → ℚ, CauchySeq u ∧ ¬∃ q : ℚ, Tendsto u atTop (𝓝 q) := by
  -- Use the classic example: decimal approximations to √2
  -- We use the fact that √2 is irrational
  have h_irr : Irrational (√2) := irrational_sqrt_two
  -- Construct a Cauchy sequence converging to √2
  -- Take u n = the largest rational ≤ √2 with denominator 2^n
  -- Instead, use a simpler approach: rational approximations from continued fraction
  -- We define the sequence via floor approximation: u n = ⌊2^n * √2⌋ / 2^n
  let u : ℕ → ℚ := fun n => ⟨⌊2^n * √2⌋, 2^n, by norm_cast; exact Nat.pow_ne_zero n (by norm_num)⟩
  -- u is Cauchy (it converges to √2 in ℝ)
  have hu_cauchy : CauchySeq u := by
    apply cauchySeq_of_eventually_dist_le
    · -- summable geometric sequence
      exact summable_of_ratio_test_tendsto_lt_one (by norm_num : (1/2 : ℝ) < 1)
        (by norm_num) (by norm_num)
    · intro n
      refine ⟨n + 1, fun m hm => ?_⟩
      simp only [u]
      -- dist (u m) (u n) ≤ (1/2)^n for m ≥ n
      sorry
  -- u does not converge in ℚ
  have h_not_conv : ¬∃ q : ℚ, Tendsto u atTop (𝓝 q) := by
    intro ⟨q, hq⟩
    have h_conv_real : Tendsto (fun n => (u n : ℝ)) atTop (𝓝 (q : ℝ)) := by
      sorry
    sorry
  exact ⟨u, hu_cauchy, h_not_conv⟩
