-- Problema 23: Regla de la cadena
-- Demuestra que (f ∘ g)' = (f' ∘ g) * g'

import Mathlib.Analysis.Calculus.Deriv.Comp

-- Para f, g diferenciables, la derivada de la composición es (f' ∘ g) * g'
-- Nota: En Mathlib, para funciones escalares f : ℝ → ℝ, g : ℝ → ℝ,
-- la regla de la cadena es: deriv (f ∘ g) x = deriv f (g x) * deriv g x
theorem chain_rule (f g : ℝ → ℝ) (x : ℝ)
    (hf : DifferentiableAt ℝ f (g x)) (hg : DifferentiableAt ℝ g x) :
    deriv (f ∘ g) x = deriv f (g x) * deriv g x := by
  exact deriv_comp x hf hg
