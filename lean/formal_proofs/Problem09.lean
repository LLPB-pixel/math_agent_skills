-- Problema 9: Traza de un producto
-- Demuestra que tr(AB) = tr(BA)
-- Para matrices 2x2: tr(AB) = Σᵢ (AB)ᵢᵢ = Σᵢ Σⱼ Aᵢⱼ Bⱼᵢ = Σⱼ (BA)ⱼⱼ = tr(BA)

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

-- La traza de un producto de matrices es conmutativa
-- Para 2x2 matrices: tr(A*B) = a₁₁b₁₁ + a₁₂b₂₁ + a₂₁b₁₂ + a₂₂b₂₂
--                    tr(B*A) = b₁₁a₁₁ + b₁₂a₂₁ + b₂₁a₁₂ + b₂₂a₂₂
-- Son iguales por conmutatividad de la multiplicación y suma.

theorem traza_producto (a₁₁ a₁₂ a₂₁ a₂₂ b₁₁ b₁₂ b₂₁ b₂₂ : ℝ) :
    (a₁₁ * b₁₁ + a₁₂ * b₂₁) + (a₂₁ * b₁₂ + a₂₂ * b₂₂) =
    (b₁₁ * a₁₁ + b₁₂ * a₂₁) + (b₂₁ * a₁₂ + b₂₂ * a₂₂) := by
  ring
