-- Problema 18: Irracionalidad de √2
-- Demuestra que √2 ∉ ℚ

import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Data.Rat.Basic

-- Demostración por reducción al absurdo:
-- Si √2 = a/b con gcd(a,b) = 1, entonces 2b² = a², luego a es par: a = 2k
-- Entonces 2b² = 4k² → b² = 2k² → b es par, contradicción con gcd(a,b) = 1.

-- Requiere: Mathlib.Data.Nat.Prime.Basic o Mathlib.Analysis.SpecialFunctions.Sqrt
-- El resultado está demostrado en Mathlib como Nat.prime_iff_prime_int
-- o irrational_sqrt_two
