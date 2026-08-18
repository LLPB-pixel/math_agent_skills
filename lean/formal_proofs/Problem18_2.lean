-- Test 83: EMV de p en Bernoulli
-- El estimador de máxima verosimilitud de p para Bernoulli es p̂ = X̄

import Mathlib.Probability.Distribution.Bernoulli
import Mathlib.Probability.Notation

-- En Mathlib, la distribución Bernoulli está definida como:
-- probabilityTheory.bernoulli p (donde p ∈ [0,1])

-- El logaritmo de la verosimilitud para n observaciones iid:
-- ℓ(p) = Σᵢ [Xᵢ log(p) + (1-Xᵢ) log(1-p)]

-- Derivando e igualando a cero:
-- dℓ/dp = Σᵢ [Xᵢ/p - (1-Xᵢ)/(1-p)] = 0
-- Resolviendo: p̂ = (1/n)ΣᵢXᵢ = X̄

-- Esto es directo por la estructura exponencial familiar de Bernoulli
-- Ver: Mathlib.Probability.Distribution.Bernoulli.logPMF
