-- Problema 12.1: Problema de Basilea
-- La suma de 1/n^2 desde n=1 hasta infinito es pi^2/6

import Mathlib.NumberTheory.ZetaValues

-- En Lean, 1/0 = 0 en ℝ, por lo que el término n=0 no contribuye.
-- hasSum_zeta_two establece exactamente la igualdad del Problema de Basilea.

theorem basilea : HasSum (fun n : ℕ => (1 : ℝ) / (n : ℝ) ^ 2) (Real.pi ^ 2 / 6) :=
  hasSum_zeta_two
