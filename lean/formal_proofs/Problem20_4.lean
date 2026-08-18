-- Test 94: Teorema de Arzelà-Ascoli
-- Una familia acotada y equicontinua de funciones continuas en un compacto
-- tiene una subsucesión convergente (su clausura es compacta).

import Mathlib.Topology.ContinuousMap.Bounded.ArzelaAscoli

open scoped BoundedContinuousFunction

/-- Teorema de Arzelà-Ascoli: si X es un espacio topológico compacto, Y un espacio
    métrico, A un conjunto de funciones continuas acotadas de X en Y, todas las funciones
    de A toman valores en un compacto s ⊆ Y, y A es equicontinua,
    entonces la clausura de A es compacta. -/
theorem arzela_ascoli_theorem
    (X Y : Type*) [TopologicalSpace X] [CompactSpace X] [MetricSpace Y]
    (s : Set Y) (hs : IsCompact s)
    (A : Set (X →ᵇ Y))
    (in_s : ∀ (f : X →ᵇ Y) (x : X), f ∈ A → f x ∈ s)
    (H : Equicontinuous ((↑) : A → X → Y)) :
    IsCompact (closure A) :=
  BoundedContinuousFunction.arzela_ascoli s hs A in_s H
