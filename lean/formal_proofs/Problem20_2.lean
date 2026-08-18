-- Test 92: Teorema de Stone-Weierstrass
-- Una subálgebra de C(X, ℝ) que separa puntos es densa.

import Mathlib.Topology.ContinuousMap.StoneWeierstrass

/-- Teorema de Stone-Weierstrass: si A es una subálgebra de C(X, ℝ), donde X es un
    espacio topológico compacto, y A separa puntos, entonces A es densa
    (su clausura topológica es todo C(X, ℝ)). -/
theorem stone_weierstrass
    {X : Type*} [TopologicalSpace X] [CompactSpace X]
    (A : Subalgebra ℝ C(X, ℝ)) (hsep : A.SeparatesPoints) :
    A.topologicalClosure = ⊤ :=
  ContinuousMap.subalgebra_topologicalClosure_eq_top_of_separatesPoints A hsep
