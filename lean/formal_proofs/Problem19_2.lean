-- Test 87: Teorema de Cayley-Hamilton
-- p_A(A) = 0, donde p_A es el polinomio característico de A

import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic

/-- **Teorema de Cayley-Hamilton**: Para cualquier matriz cuadrada A sobre un anillo conmutativo,
    el polinomio característico evaluado en la propia matriz es cero: p_A(A) = 0. -/
theorem cayley_hamilton {n : Type*} [DecidableEq n] [Fintype n]
    {R : Type*} [CommRing R] (A : Matrix n n R) :
    Polynomial.aeval A A.charpoly = 0 :=
  Matrix.aeval_self_charpoly A
