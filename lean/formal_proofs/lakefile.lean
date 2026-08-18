import Lake
open Lake DSL

package math_proofs where
  leanOptions := #[⟨`autoImplicit, false⟩]

@[default_target]
lean_lib MathProofs where
  srcDir := "."
  roots := #[`Problem05_1, `Problem05_2, `Problem05_3, `Problem05_4, `Problem05_5,
    `Problem10_1, `Problem10_2, `Problem10_3, `Problem10_4, `Problem10_5,
    `Problem11_1, `Problem11_2, `Problem11_3, `Problem11_4, `Problem11_5,
    `Problem12_1,
    `Problem14_1, `Problem14_2, `Problem14_3, `Problem14_4, `Problem14_5,
    `Problem15_1, `Problem15_2, `Problem15_3, `Problem15_4, `Problem15_5,
    `Problem13_1, `Problem13_2, `Problem13_3, `Problem13_4, `Problem13_5,
    `Problem16_1, `Problem16_2, `Problem16_3, `Problem16_4, `Problem16_5,
    `Problem18_1, `Problem18_2, `Problem18_3, `Problem18_4,
    `Problem19_1, `Problem19_2, `Problem19_3, `Problem19_4, `Problem19_5,
    `Problem20_1, `Problem20_2, `Problem20_3, `Problem20_4, `Problem20_5]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"
