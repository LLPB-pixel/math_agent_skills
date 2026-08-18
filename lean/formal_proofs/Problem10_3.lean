-- Problema 48: ℝ es completo
-- El espacio de los números reales es un espacio completo

import Mathlib.Topology.UniformSpace.Real

theorem real_is_complete : CompleteSpace ℝ :=
  Real.instCompleteSpace
