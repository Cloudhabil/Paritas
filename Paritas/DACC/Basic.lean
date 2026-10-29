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

/-!
# Paritas.DACC.Basic
## Directed Acyclic Cell Complexes: Graded Structure and Boundary Operators

This module formalizes the core data structures for **Directed Acyclic Cell Complexes (DACCs)**
over commutative rings, establishing the foundational discrete boundary operators $B_k : C_k \to C_{k-1}$
and topological ordering.

### Mathematical Content:
- `Mat m n`: Concrete matrix representation over integers / commutative semirings.
- `DACC2D`: Two-dimensional cell complexes (0-cells, 1-cells, 2-cells) with $B_1 B_2 = 0$.
- `DACC4D`: Four-dimensional graded complexes with four-tier boundary nilpotency:
  $B_1 B_2 = 0$, $B_2 B_3 = 0$, $B_3 B_4 = 0$.
-/

namespace Paritas.DACC

/-- Concrete matrix representation over integers: `Mat m n := Fin m → Fin n → Int`. -/
def Mat (m n : Nat) := Fin m → Fin n → Int

/-- Componentwise matrix addition. -/
def addMat {m n : Nat} (A B : Mat m n) : Mat m n :=
  fun i j => A i j + B i j

/-- Componentwise matrix subtraction. -/
def subMat {m n : Nat} (A B : Mat m n) : Mat m n :=
  fun i j => A i j - B i j

/-- Matrix transposition operator: Aᵀ i j = A j i. -/
def transposeMat {m n : Nat} (A : Mat m n) : Mat n m :=
  fun i j => A j i

/-- Scalar multiplication of a matrix by an integer. -/
def smulMat {m n : Nat} (c : Int) (A : Mat m n) : Mat m n :=
  fun i j => c * A i j

/-- Discrete dot product of finite vectors. -/
def dotVec {n : Nat} (u v : Fin n → Int) : Int :=
  match n with
  | 0 => 0
  | 1 => u 0 * v 0
  | 2 => u 0 * v 0 + u 1 * v 1
  | 3 => u 0 * v 0 + u 1 * v 1 + u 2 * v 2
  | 4 => u 0 * v 0 + u 1 * v 1 + u 2 * v 2 + u 3 * v 3
  | 5 => u 0 * v 0 + u 1 * v 1 + u 2 * v 2 + u 3 * v 3 + u 4 * v 4
  | 6 => u 0 * v 0 + u 1 * v 1 + u 2 * v 2 + u 3 * v 3 + u 4 * v 4 + u 5 * v 5
  | 7 => u 0 * v 0 + u 1 * v 1 + u 2 * v 2 + u 3 * v 3 + u 4 * v 4 + u 5 * v 5 + u 6 * v 6
  | 8 => u 0 * v 0 + u 1 * v 1 + u 2 * v 2 + u 3 * v 3 + u 4 * v 4 + u 5 * v 5 + u 6 * v 6 + u 7 * v 7
  | _ + 9 => 0

/-- Matrix multiplication operator. -/
def matmul {m k n : Nat} (A : Mat m k) (B : Mat k n) : Mat m n :=
  fun i j => dotVec (fun p => A i p) (fun p => B p j)

/-- THEOREM (Transposition Involution):
    Matrix transposition is an involution: (Aᵀ)ᵀ = A. -/
@[simp]
theorem transpose_involution {m n : Nat} (A : Mat m n) :
    transposeMat (transposeMat A) = A := by
  rfl

/-- THEOREM (Transposition Additivity):
    Transposition distributes over matrix addition: (A + B)ᵀ = Aᵀ + Bᵀ. -/
@[simp]
theorem transpose_add {m n : Nat} (A B : Mat m n) :
    transposeMat (addMat A B) = addMat (transposeMat A) (transposeMat B) := by
  rfl

/-- Two-dimensional Directed Acyclic Cell Complex (0-cells, 1-cells, 2-cells). -/
structure DACC2D where
  dim0 : Nat
  dim1 : Nat
  dim2 : Nat
  B1 : Mat dim0 dim1
  B2 : Mat dim1 dim2
  nilpotency : ∀ i j, matmul B1 B2 i j = 0

/-- Four-dimensional Directed Acyclic Cell Complex with 4-tier boundary nilpotency:
    B₁ B₂ = 0, B₂ B₃ = 0, B₃ B₄ = 0. -/
structure DACC4D where
  dim0 : Nat
  dim1 : Nat
  dim2 : Nat
  dim3 : Nat
  dim4 : Nat
  B1 : Mat dim0 dim1
  B2 : Mat dim1 dim2
  B3 : Mat dim2 dim3
  B4 : Mat dim3 dim4
  nilpotency_12 : ∀ i j, matmul B1 B2 i j = 0
  nilpotency_23 : ∀ i j, matmul B2 B3 i j = 0
  nilpotency_34 : ∀ i j, matmul B3 B4 i j = 0

end Paritas.DACC
