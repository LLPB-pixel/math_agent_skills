import Mathlib.Data.Real.Basic
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Topology.Order.IntermediateValue

/-- Problem 35: Intermediate Value Theorem -/
theorem ivt_theorem {f : ℝ → ℝ} (hf : Continuous f)
    {a b y : ℝ} (ha : f a < y) (hb : y < f b) :
    ∃ c, f c = y :=
  let ⟨c, hc⟩ := intermediate_value_univ₂ hf continuous_const (le_of_lt ha) (le_of_lt hb)
  ⟨c, hc⟩
