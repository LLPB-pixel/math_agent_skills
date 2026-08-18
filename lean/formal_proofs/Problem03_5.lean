-- Problema 15: Subgrupos de grupos cíclicos son cíclicos
-- Demostración: Todo subgrupo de un grupo cíclico es cíclico.
--
-- En Mathlib, `Subgroup.isCyclic` es una instancia que establece
-- que si α es cíclico, entonces cualquier subgrupo H ≤ α es cíclico.

import Mathlib.GroupTheory.SpecificGroups.Cyclic.Basic

theorem subgrupos_ciclicos_son_ciclicos {G : Type*} [Group G] [IsCyclic G]
    (H : Subgroup G) : IsCyclic H :=
  Subgroup.isCyclic H
