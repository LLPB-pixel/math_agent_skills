-- Problema 17: Infinitud de primos
-- Demuestra que existen infinitos números primos

-- Demostración clásica por reducción al absurdo:
-- Si solo hay primos finitos p₁,...,pₙ, consideramos N = p₁·p₂·...·pₙ + 1.
-- N no es divisible por ningún pᵢ, contradicción.

-- Requiere Mathlib.Data.Nat.Prime.Infinite
-- El resultado está demostrado en Mathlib como Nat.exists_infinite_primes
