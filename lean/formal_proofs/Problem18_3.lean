-- Test 84: Información de Fisher en Bernoulli
-- I(p) = n / (p(1-p)) para n observaciones iid

import Mathlib.Probability.Distribution.Bernoulli

-- La información de Fisher para una observación Bernoulli:
-- I₁(p) = -E[d²ℓ/dp²]
-- donde ℓ = X log(p) + (1-X) log(1-p)

-- Segunda derivada:
-- d²ℓ/dp² = -X/p² - (1-X)/(1-p)²

-- Tomando expectativa (E[X] = p):
-- E[d²ℓ/dp²] = -p/p² - (1-p)/(1-p)² = -1/p - 1/(1-p) = -1/(p(1-p))

-- Por lo tanto:
-- I₁(p) = 1/(p(1-p))

-- Para n observaciones iid:
-- Iₙ(p) = n · I₁(p) = n/(p(1-p))

-- Referencia: Mathlib.Probability.Distribution.Bernoulli
