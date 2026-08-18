-- Problema 9: Traza de un producto
-- tr(AB) = tr(BA) para matrices cuadradas
-- Demostrado para matrices 2×2

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

theorem traza_producto (a₁₁ a₁₂ a₂₁ a₂₂ b₁₁ b₁₂ b₂₁ b₂₂ : ℝ) :
    (a₁₁ * b₁₁ + a₁₂ * b₂₁ + a₂₁ * b₁₂ + a₂₂ * b₂₂) =
    (b₁₁ * a₁₁ + b₁₂ * a₂₁ + b₂₁ * a₁₂ + b₂₂ * a₂₂) := by
  ring
