-- Problema 8.1: Teorema de Rolle
-- Si f continua en [a,b], derivable en (a,b), f(a)=f(b), existe c con f'(c)=0

import Mathlib.Analysis.Calculus.LocalExtr.Rolle
import Mathlib.Topology.Order.Rolle

/-- **Teorema de Rolle**: Si f es continua en [a,b], derivable en (a,b), y f(a) = f(b),
    entonces existe c ∈ (a,b) tal que f'(c) = 0. -/
theorem rolle_theorem {f : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfI : f a = f b) :
    ∃ c ∈ Set.Ioo a b, deriv f c = 0 :=
  exists_deriv_eq_zero hab hfc hfI