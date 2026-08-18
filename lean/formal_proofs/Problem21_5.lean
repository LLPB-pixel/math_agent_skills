-- Test 100: Teorema de los números primos (desigualdades de Chebyshev)
-- π(x) ~ x/ln x: cotas superior e inferior para la función de conteo de primos

import Mathlib.NumberTheory.Chebyshev
import Mathlib.NumberTheory.PrimeCounting

open Chebyshev Filter

/-- **Cota superior de Chebyshev**: Para cualquier ε > 0, eventualmente
    π(x) ≤ (log 4 + ε) * x / log x. -/
theorem prime_number_upper_bound {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ x in atTop, ↑⌊x⌋₊.primeCounting ≤ (Real.log 4 + ε) * x / Real.log x := by
  exact eventually_primeCounting_le hε

/-- **Cota inferior de Chebyshev**: Para n ≥ 2,
    (n * log 2 - log(n + 1)) / log n ≤ π(n). -/
theorem prime_number_lower_bound (n : ℕ) :
    (↑n * Real.log 2 - Real.log (↑n + 1)) / Real.log ↑n ≤ ↑n.primeCounting := by
  exact pi_ge n

/-- **Cota superior explícita**: Para x > 1,
    π(⌊x⌋₊) ≤ log 4 * x / log √x + √x. -/
theorem prime_counting_explicit_upper {x : ℝ} (hx : 1 < x) :
    ↑⌊x⌋₊.primeCounting ≤ Real.log 4 * x / Real.log (Real.sqrt x) + Real.sqrt x := by
  exact pi_le_log4_mul_div hx
