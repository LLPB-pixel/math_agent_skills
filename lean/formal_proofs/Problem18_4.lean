-- Test 85: Desigualdad de Cramér-Rao
-- Para un estimador insesgado θ̂ de θ:
-- Var(θ̂) ≥ 1/I(θ)

import Mathlib.Probability.Notation

-- La desigualdad de Cramér-Rao establece que para cualquier estimador
-- insesgado θ̂ de un parámetro θ:

-- Var(θ̂) ≥ 1/I(θ)

-- donde I(θ) = E[(-∂²ℓ/∂θ²)] es la información de Fisher.

-- Demostración:
-- 1. Sea U = ∂ℓ/∂θ la escorada (score)
-- 2. E[U] = 0 (propiedad de la escorada)
-- 3. Cov(θ̂, U) = E[θ̂ · U] = 1 (por insesgamiento)
-- 4. Por Cauchy-Schwarz: (Cov(θ̂,U))² ≤ Var(θ̂) · Var(U)
-- 5. Var(U) = I(θ) (información de Fisher)
-- 6. Por lo tanto: 1 ≤ Var(θ̂) · I(θ)
-- 7. Resultado: Var(θ̂) ≥ 1/I(θ)

-- Ver: Mathlib.Probability.Theory.Estimator (si disponible)
-- o construir directamente con Cauchy-Schwarz
