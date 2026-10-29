/-
Copyright 2026 The Paritas & ToposLang Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/

import Paritas.DACC.Basic

/-!
# Paritas.DACC.Duality
## Cellular Poincaré–Lefschetz Parity Duality & Handlebody Plumbing

This module formalizes **DACC Parity Duality**: the identification of cellular transposition
$(\cdot)^T$ with Poincaré–Lefschetz duality coupling chain complexes to cochain complexes.

### Key Theorems:
- `dacc_parity_coupling_symmetric`: Proves that for ANY DACC incidence operator B,
  the self-coupling $I = B + B^T$ is universally symmetric under transposition.
- `e8_dacc_parity_instantiation`: Proves that the $8 \times 8$ $E_8$ Cartan intersection form
  is identically the DACC Parity Coupling of the upper-triangular Dynkin DAG incidence matrix:
  $$I_{E_8} = B_{\text{dacc}} + B_{\text{dacc}}^T$$
-/

namespace Paritas.DACC

/-- Discrete Coboundary Operator (DACC Transposition): δ₁ = B₂ᵀ. -/
def coboundary1 {d1 d2 : Nat} (B2 : Mat d1 d2) : Mat d2 d1 :=
  transposeMat B2

/-- DACC Parity Self-Coupling Operator: I = B + Bᵀ.
    Algebraically encodes the geometric fiber-base swap (x, y) ↦ (y, x) during disk bundle plumbing. -/
def daccParityCoupling {n : Nat} (B : Mat n n) : Mat n n :=
  addMat B (transposeMat B)

/-- THEOREM (Universal DACC Parity Symmetry):
    For ANY DACC incidence operator B, the self-coupling I = B + Bᵀ is universally symmetric. -/
theorem dacc_parity_coupling_symmetric {n : Nat} (B : Mat n n) :
    transposeMat (daccParityCoupling B) = daccParityCoupling B := by
  dsimp [daccParityCoupling, addMat, transposeMat]
  funext i j
  exact Int.add_comm (B j i) (B i j)

/-- The E₈ Plumbing DACC Incidence Matrix B_dacc:
    Upper-triangular directed incidence matrix of the E₈ Dynkin tree.
    Diagonal entries = 1 (half of χ(S⁴) = 2 of base 4-sphere).
    Off-diagonal entries = -1 along directed edges radiating from the trivalent node (index 2). -/
def E8_B_dacc : Mat 8 8
  | 0, 0 =>  1 | 0, 1 => -1 | 0, 2 =>  0 | 0, 3 =>  0 | 0, 4 =>  0 | 0, 5 =>  0 | 0, 6 =>  0 | 0, 7 =>  0
  | 1, 0 =>  0 | 1, 1 =>  1 | 1, 2 => -1 | 1, 3 =>  0 | 1, 4 =>  0 | 1, 5 =>  0 | 1, 6 =>  0 | 1, 7 =>  0
  | 2, 0 =>  0 | 2, 1 =>  0 | 2, 2 =>  1 | 2, 3 => -1 | 2, 4 =>  0 | 2, 5 =>  0 | 2, 6 =>  0 | 2, 7 => -1
  | 3, 0 =>  0 | 3, 1 =>  0 | 3, 2 =>  0 | 3, 3 =>  1 | 3, 4 => -1 | 3, 5 =>  0 | 3, 6 =>  0 | 3, 7 =>  0
  | 4, 0 =>  0 | 4, 1 =>  0 | 4, 2 =>  0 | 4, 3 =>  0 | 4, 4 =>  1 | 4, 5 => -1 | 4, 6 =>  0 | 4, 7 =>  0
  | 5, 0 =>  0 | 5, 1 =>  0 | 5, 2 =>  0 | 5, 3 =>  0 | 5, 4 =>  0 | 5, 5 =>  1 | 5, 6 => -1 | 5, 7 =>  0
  | 6, 0 =>  0 | 6, 1 =>  0 | 6, 2 =>  0 | 6, 3 =>  0 | 6, 4 =>  0 | 6, 5 =>  0 | 6, 6 =>  1 | 6, 7 =>  0
  | 7, 0 =>  0 | 7, 1 =>  0 | 7, 2 =>  0 | 7, 3 =>  0 | 7, 4 =>  0 | 7, 5 =>  0 | 7, 6 =>  0 | 7, 7 =>  1

/-- THEOREM (E₈ Plumbing DACC Parity Instantiation):
    The E₈ Cartan intersection form is identically the DACC Parity Coupling of E8_B_dacc:
      I_{E8} = B_{dacc} + B_{dacc}ᵀ. -/
theorem e8_dacc_parity_instantiation (i j : Fin 8) :
    daccParityCoupling E8_B_dacc i j =
      match i.val, j.val with
      | 0, 0 => 2 | 0, 1 => -1 | 1, 0 => -1 | 1, 1 => 2 | 1, 2 => -1 | 2, 1 => -1
      | 2, 2 => 2 | 2, 3 => -1 | 2, 7 => -1 | 3, 2 => -1 | 3, 3 => 2 | 3, 4 => -1
      | 4, 3 => -1 | 4, 4 => 2 | 4, 5 => -1 | 5, 4 => -1 | 5, 5 => 2 | 5, 6 => -1
      | 6, 5 => -1 | 6, 6 => 2 | 7, 2 => -1 | 7, 7 => 2
      | _, _ => 0 := by
  revert i j
  decide

end Paritas.DACC
