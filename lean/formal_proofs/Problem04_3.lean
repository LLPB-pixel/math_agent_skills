-- Problema 18: Irracionalidad de √2
-- Demuestra que √2 no es racional

import Mathlib.NumberTheory.Real.Irrational

theorem irracionalidad_sqrt_two : Irrational (Real.sqrt 2) :=
  irrational_sqrt_two
