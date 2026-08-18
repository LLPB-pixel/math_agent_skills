-- Test 88: Teorema Espectral
-- Las matrices simétricas (Hermitianas) son diagonalizables

import Mathlib.Analysis.Matrix.Spectrum

open Matrix

/-- **Teorema Espectral para matrices**: Toda matriz Hermitiana (simétrica en el caso real)
    es diagonalizable por una matriz unitaria.
    Es decir, A = U D U* donde D es diagonal y U es unitaria. -/
theorem spectral_theorem_matrices {𝕜 : Type*} [RCLike 𝕜] {n : Type*} [DecidableEq n] [Fintype n]
    {A : Matrix n n 𝕜} (hA : A.IsHermitian) :
    A = Unitary.conjStarAlgAut 𝕜 _ hA.eigenvectorUnitary
          (Matrix.diagonal (RCLike.ofReal ∘ hA.eigenvalues)) :=
  hA.spectral_theorem

/-- Toda matriz Hermitiana admite una base ortonormal de autoVectores. -/
theorem hermitian_has_orthonormal_eigenvectors {𝕜 : Type*} [RCLike 𝕜] {n : Type*}
    [DecidableEq n] [Fintype n] {A : Matrix n n 𝕜} (hA : A.IsHermitian) :
    ∃ basis : OrthonormalBasis n 𝕜 (EuclideanSpace 𝕜 n),
      ∀ j, A.mulVec (basis j) = (hA.eigenvalues j) • (basis j : EuclideanSpace 𝕜 n) :=
  ⟨hA.eigenvectorBasis, hA.mulVec_eigenvectorBasis⟩
