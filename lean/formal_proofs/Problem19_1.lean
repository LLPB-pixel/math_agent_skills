-- Test 86: Teorema Fundamental del Álgebra
-- Todo polinomio no constante tiene raíz en ℂ

import Mathlib.Analysis.Complex.Polynomial.Basic

open Polynomial

/-- **Teorema Fundamental del Álgebra**: Todo polinomio no constante sobre ℂ tiene al menos una raíz. -/
theorem fundamental_theorem_of_algebra {f : ℂ[X]} (hf : 0 < degree f) :
    ∃ z : ℂ, f.IsRoot z :=
  Complex.exists_root hf

/-- ℂ es algebraicamente cerrado: todo polinomio irreducible tiene raíz. -/
theorem complex_is_algebraically_closed : IsAlgClosed ℂ :=
  Complex.isAlgClosed
