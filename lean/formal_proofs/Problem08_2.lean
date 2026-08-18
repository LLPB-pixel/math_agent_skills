-- Problema 8.2: Teorema del Valor Medio
-- Si f continua en [a,b], derivable en (a,b), existe c con f'(c) = (f(b)-f(a))/(b-a)

import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-- **Teorema del Valor Medio (Lagrange)**: Si f es continua en [a,b] y derivable en (a,b),
    existe c ∈ (a,b) tal que f'(c) = (f(b) - f(a)) / (b - a). -/
theorem mean_value_theorem {f : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b)) :
    ∃ c ∈ Set.Ioo a b, deriv f c = (f b - f a) / (b - a) :=
  exists_deriv_eq_slope f hab hfc hfd