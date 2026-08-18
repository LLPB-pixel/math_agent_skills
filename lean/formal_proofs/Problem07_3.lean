import Mathlib.Data.Real.Basic
import Mathlib.Analysis.Convex.Function
import Mathlib.Tactic.Linarith

/-- Problem 33: Jensen's inequality for convex combinations of two points -/
theorem jensen_two_points (f : ℝ → ℝ) (s : Set ℝ) (hf : ConvexOn ℝ s f)
    {x y : ℝ} (hx : x ∈ s) (hy : y ∈ s)
    {t : ℝ} (ht₀ : 0 ≤ t) (ht₁ : t ≤ 1) :
    f (t * x + (1 - t) * y) ≤ t * f x + (1 - t) * f y := by
  have h₂ : 0 ≤ 1 - t := by linarith
  have h₃ : t + (1 - t) = 1 := by linarith
  exact hf.2 hx hy ht₀ h₂ h₃
