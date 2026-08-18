-- Problema 8.4: Derivada positiva implica creciente
-- Si f'(x) > 0, f es estrictamente creciente

import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-- **Derivada positiva implica estrictamente creciente**:
    Si f'(x) > 0 para todo x, entonces f es estrictamente creciente. -/
theorem strictMono_of_deriv_pos' {f : ℝ → ℝ}
    (hf' : ∀ x, 0 < deriv f x) : StrictMono f :=
  strictMono_of_deriv_pos hf'