-- Problema 13: Determinante de un producto
-- Demuestra que det(AB) = det(A)det(B)
--
-- Demostración: En Mathlib, `Matrix.det_mul` establece exactamente este resultado
-- para matrices cuadradas sobre anillos conmutativos.

import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

open Matrix in
theorem det_producto (n : Type*) [Fintype n] [DecidableEq n]
    (A B : Matrix n n ℝ) : det (A * B) = det A * det B :=
  det_mul A B
