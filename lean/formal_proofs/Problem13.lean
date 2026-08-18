-- Problema 13: Determinante de un producto
-- Demuestra que det(AB) = det(A)det(B) para matrices 2x2

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

-- Para matrices 2x2 con entradas reales
-- A = [[a,b],[c,d]], B = [[e,f],[g,h]]
-- AB = [[ae+bg, af+bh],[ce+dg, cf+dh]]
-- det(AB) = (ae+bg)(cf+dh) - (af+bh)(ce+dg)
-- det(A)det(B) = (ad-bc)(eh-fg)

theorem det_producto_2x2 (a b c d e f g h : ℝ) :
    (a*e + b*g)*(c*f + d*h) - (a*f + b*h)*(c*e + d*g) =
    (a*d - b*c)*(e*h - f*g) := by
  ring
