import Mathlib.Analysis.Convex.SpecificFunctions.Basic

/-- Problem 32: exp is convex on ℝ -/
theorem exp_convex : ConvexOn ℝ Set.univ Real.exp :=
  convexOn_exp
