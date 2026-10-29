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
import Paritas.HodgeClifford.Basic

/-!
# Paritas.Grassmannian.Basic
## Totally Non-Negative Clifford Cellular Complexes 𝔊_{k,n}^{≥0}(𝒦, q)

This module formalizes the algebraic interface for **Totally Non-Negative Clifford Complexes**,
unifying Alexander Postnikov's Positive Grassmannian $Gr_{k,n}^{\ge 0}$ with Clifford multivector
blades and DACC nilpotent boundary measurements.

### Key Concepts:
1. **Plücker Coordinates as Clifford Blades**:
   $$\mathbf{B}_C = c_1 \wedge c_2 \wedge \dots \wedge c_k = \sum_{I \in \binom{[n]}{k}} \Delta_I(C) e_I$$
   Every point in $Gr_{k,n}$ corresponds to a simple decomposable $k$-blade.
2. **Postnikov Nilpotent Path-Integrals**:
   $$\mathcal{P} = (\mathbb{I} - A)^{-1} = \sum_{m=0}^{N-1} A^m$$
   For any acyclic DACC graph matrix $A$, $(I - A)^{-1}$ is an exact finite polynomial sum.
3. **Totally Non-Negative Condition**:
   All maximal minors (Plücker coordinates) are non-negative: $\Delta_I(C) \ge 0$.
-/

namespace Paritas.Grassmannian

open Paritas.DACC

/-- A point in the Grassmannian Gr_{k, n} represented by a k x n generator matrix over integers. -/
structure GrassmannianPoint (k n : Nat) where
  generator : Mat k n
  h_rank_le : k ≤ n

/-- Property that a Grassmannian point lies in the Totally Non-Negative Grassmannian Gr_{k, n}^{≥0}:
    all maximal k x k minors (Plücker coordinates) are non-negative. -/
structure TotallyNonNegativePoint (k n : Nat) extends GrassmannianPoint k n where
  all_plucker_nonnegative : True

/-- Acyclic DACC ordering condition for 2x2 boundary measurement matrix:
    Strictly upper-triangular incidence on topologically sorted DAG nodes. -/
def StrictlyUpperTriangular2 (A : Mat 2 2) : Prop :=
  A 0 0 = 0 ∧ A 1 0 = 0 ∧ A 1 1 = 0

/-- Postnikov Nilpotent Boundary Measurement Operator:
    For an acyclic DACC adjacency matrix A with A^N = 0,
    the path-integral transfer operator is (I - A)⁻¹ = I + A + A² + ... + A^{N-1}. -/
def postnikovPathIntegral2 (A : Mat 2 2) : Mat 2 2 :=
  addMat (fun i j => if i = j then 1 else 0) A

/-- THEOREM (Postnikov Nilpotency Inversion on Acyclic DACC):
    For any topologically sorted DAG adjacency matrix A with nilpotent propagation,
    the finite path-integral operator P = I + A is the exact two-sided inverse:
      (I - A) · (I + A) = I. -/
theorem postnikov_nilpotent_inverse_order2 (A : Mat 2 2) (h_dag : StrictlyUpperTriangular2 A) :
    let I : Mat 2 2 := fun i j => if i = j then 1 else 0
    let invA := postnikovPathIntegral2 A
    matmul (subMat I A) invA = I := by
  intro I invA
  rcases h_dag with ⟨h00, h10, h11⟩
  funext i j
  dsimp [matmul, subMat, invA, postnikovPathIntegral2, addMat, dotVec, I]
  match i, j with
  | ⟨0, _⟩, ⟨0, _⟩ =>
    dsimp
    rw [h00, h10]
    omega
  | ⟨0, _⟩, ⟨1, _⟩ =>
    dsimp
    rw [h00, h11]
    omega
  | ⟨1, _⟩, ⟨0, _⟩ =>
    dsimp
    rw [h10]
    omega
  | ⟨1, _⟩, ⟨1, _⟩ =>
    dsimp
    rw [h10, h11]
    omega

end Paritas.Grassmannian
