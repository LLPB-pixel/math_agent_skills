-- Test 90: Teorema de Hahn-Banach
-- Extensión de funcionales lineales acotados

import Mathlib.Analysis.Normed.Module.HahnBanach

/-- **Teorema de Hahn-Banach**: Todo funcional lineal continuo definido en un subespacio
    de un espacio vectorial normado puede extenderse al espacio completo sin cambiar su norma. -/
theorem hahn_banach_extension {𝕜 : Type*} [NontriviallyNormedField 𝕜] [IsRCLikeNormedField 𝕜]
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace 𝕜 E]
    (p : Subspace 𝕜 E) (f : StrongDual 𝕜 p) :
    ∃ g : StrongDual 𝕜 E, (∀ x : p, g x = f x) ∧ ‖g‖ = ‖f‖ :=
  exists_extension_norm_eq p f

/-- Corolario de Hahn-Banach: Para cualquier elemento no nulo x, existe un funcional
    dual de norma 1 cuyo valor en x es ‖x‖. -/
theorem hahn_banach_dual_vector {𝕜 : Type*} [RCLike 𝕜]
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace 𝕜 E]
    (x : E) (h : ‖x‖ ≠ 0) :
    ∃ g : StrongDual 𝕜 E, ‖g‖ = 1 ∧ g x = ‖x‖ :=
  exists_dual_vector 𝕜 x h
