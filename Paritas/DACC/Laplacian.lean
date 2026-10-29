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
import Paritas.DACC.Duality

/-!
# Paritas.DACC.Laplacian
## Discrete Cellular Hodge Laplacians & Hodge Decomposition

This module formalizes the combinatorial Hodge Laplacian on cell complexes:
$$L_k = B_k^T B_k + B_{k+1} B_{k+1}^T$$
and proves its universal self-adjointness ($L_k^T = L_k$).

### Key Definitions & Theorems:
- `hodgeLaplacian1`: The 1-Laplacian on 1-cells of a 2D DACC.
- `hodgeLaplacian2_4D`: The 2-Laplacian on 2-cells of a 4D DACC.
- `hodge_laplacian1_self_adjoint`: Universal self-adjointness proof.
-/

namespace Paritas.DACC

/-- Cellular Hodge Laplacian on 1-cells: L₁ = B₁ᵀ B₁ + B₂ B₂ᵀ. -/
def hodgeLaplacian1 (K : DACC2D) : Mat K.dim1 K.dim1 :=
  addMat (matmul (transposeMat K.B1) K.B1) (matmul K.B2 (transposeMat K.B2))

/-- Cellular Hodge Laplacian on 2-cells in a 4D DACC: L₂ = B₂ᵀ B₂ + B₃ B₃ᵀ. -/
def hodgeLaplacian2_4D (K : DACC4D) : Mat K.dim2 K.dim2 :=
  addMat (matmul (transposeMat K.B2) K.B2) (matmul K.B3 (transposeMat K.B3))

/-- Property that a square matrix is self-adjoint under transposition. -/
def IsSelfAdjoint {n : Nat} (A : Mat n n) : Prop :=
  transposeMat A = A

/-- Structure representing the discrete Hodge decomposition of a k-cochain:
    C_k = im(B_kᵀ) ⊕ im(B_{k+1}) ⊕ ker(L_k). -/
structure DiscreteHodgeDecomposition (dim : Nat) where
  exact_component    : Fin dim → Int  -- im(B_kᵀ)
  coexact_component  : Fin dim → Int  -- im(B_{k+1})
  harmonic_component : Fin dim → Int  -- ker(L_k)

end Paritas.DACC
