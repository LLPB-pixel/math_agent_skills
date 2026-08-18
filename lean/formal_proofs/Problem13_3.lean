-- Problema 59: Unicidad con Lipschitz
-- Unicidad de solución bajo condición de Lipschitz (Picard-Lindelöf)

import Mathlib.Analysis.ODE.ExistUnique

/-- Unicidad de soluciones de EDOs bajo condición de Lipschitz global.
    Si v(t) es Lipschitz para cada t, y f, g son soluciones con la misma
    condición inicial en [a,b], entonces f = g en [a,b]. -/
theorem ode_uniqueness_lipschitz
    {v : ℝ → ℝ → ℝ} {f g : ℝ → ℝ} {a b : ℝ}
    {K : NNReal}
    (hv : ∀ t, LipschitzWith K (v t))
    (hf : ContinuousOn f (Set.Icc a b))
    (hf' : ∀ t ∈ Set.Ico a b, HasDerivWithinAt f (v t (f t)) (Set.Ici t) t)
    (hg : ContinuousOn g (Set.Icc a b))
    (hg' : ∀ t ∈ Set.Ico a b, HasDerivWithinAt g (v t (g t)) (Set.Ici t) t)
    (ha : f a = g a) :
    Set.EqOn f g (Set.Icc a b) :=
  ODE_solution_unique hv hf hf' hg hg' ha

/-- Unicidad global de soluciones de EDOs bajo condición de Lipschitz.
    Si v(t) es Lipschitz para cada t, y f, g son soluciones definidas para todo t
    con la misma condición inicial, entonces f = g. -/
theorem ode_uniqueness_lipschitz_univ
    {v : ℝ → ℝ → ℝ} {f g : ℝ → ℝ} {t₀ : ℝ}
    {K : NNReal}
    (hv : ∀ t, LipschitzWith K (v t))
    (hf : ∀ t, HasDerivAt f (v t (f t)) t)
    (hg : ∀ t, HasDerivAt g (v t (g t)) t)
    (heq : f t₀ = g t₀) :
    f = g :=
  ODE_solution_unique_univ
    (fun t => lipschitzOnWith_univ.mpr (hv t))
    (fun t => ⟨hf t, Set.mem_univ _⟩)
    (fun t => ⟨hg t, Set.mem_univ _⟩)
    heq
