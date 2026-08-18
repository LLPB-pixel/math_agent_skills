import Mathlib.Data.Real.Basic
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Topology.Order.Compact
import Mathlib.Order.Interval.Set.Basic

/-- Problem 34: A continuous function on [a,b] attains its minimum -/
theorem continuous_attains_min {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : ContinuousOn f (Set.Icc a b)) :
    ∃ x ∈ Set.Icc a b, ∀ y ∈ Set.Icc a b, f x ≤ f y :=
  isCompact_Icc.exists_isMinOn (Set.nonempty_Icc.mpr hab) hf

/-- Problem 34: A continuous function on [a,b] attains its maximum -/
theorem continuous_attains_max {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : ContinuousOn f (Set.Icc a b)) :
    ∃ x ∈ Set.Icc a b, ∀ y ∈ Set.Icc a b, f y ≤ f x :=
  isCompact_Icc.exists_isMaxOn (Set.nonempty_Icc.mpr hab) hf
