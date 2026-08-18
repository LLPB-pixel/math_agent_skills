-- Problema 22: Regla del producto
-- Demuestra que (f * g)' = f' * g + f * g'

import Mathlib.Analysis.Calculus.Deriv.Mul

-- Para f, g diferenciables en x, la derivada del producto es f'g + fg'
theorem product_rule (f g : ℝ → ℝ) (x : ℝ)
    (hf : DifferentiableAt ℝ f x) (hg : DifferentiableAt ℝ g x) :
    deriv (f * g) x = deriv f x * g x + f x * deriv g x := by
  exact deriv_mul hf hg
