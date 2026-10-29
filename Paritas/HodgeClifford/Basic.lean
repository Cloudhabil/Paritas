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
# Paritas.HodgeClifford.Basic
## Discrete Clifford Geometric Algebras and Multivector Cochains

This module formalizes discrete Clifford multivector cochains assigned to cell complexes:
every cell carries a multivector stalk in $\mathrm{Cl}(p, q, r)$ equipped with the geometric product:
$$u v = u \cdot v + u \wedge v$$
combining interior contraction and exterior wedge products into a single invertible operator.
-/

namespace Paritas.HodgeClifford

open Paritas.DACC

/-- Signature of a real Clifford algebra Cl(p, q, r) with p positive, q negative, and r degenerate dimensions. -/
structure CliffordSignature where
  p : Nat
  q : Nat
  r : Nat

/-- Standard 4D Euclidean spacetime signature Cl(4, 0, 0). -/
def Euclidean4D : CliffordSignature where
  p := 4
  q := 0
  r := 0

/-- Standard 8D Euclidean signature Cl(8, 0, 0). -/
def Euclidean8D : CliffordSignature where
  p := 8
  q := 0
  r := 0

/-- Multivector stalk dimension for Cl(p, q, r): 2^(p + q + r). -/
def multivectorDim (sig : CliffordSignature) : Nat :=
  2 ^ (sig.p + sig.q + sig.r)

theorem euclidean4d_multivector_dim : multivectorDim Euclidean4D = 16 := rfl
theorem euclidean8d_multivector_dim : multivectorDim Euclidean8D = 256 := rfl

theorem multivectorDim_pos (sig : CliffordSignature) : 0 < multivectorDim sig := by
  dsimp [multivectorDim]
  have h2 : 0 < 2 := by decide
  exact Nat.pos_pow_of_pos (sig.p + sig.q + sig.r) h2

/-- Zero index for blade basis (representing the grade-0 scalar identity 1). -/
def zeroIdx (sig : CliffordSignature) : Fin (multivectorDim sig) :=
  ⟨0, multivectorDim_pos sig⟩

/-- Multivector element in Cl(p, q, r) represented as coefficient array over 2^d basis blades. -/
structure Multivector (sig : CliffordSignature) where
  components : Fin (multivectorDim sig) → Int

/-- Componentwise addition of multivectors. -/
def addMv {sig : CliffordSignature} (u v : Multivector sig) : Multivector sig where
  components := fun i => u.components i + v.components i

/-- Grade-0 scalar part of a multivector (index 0). -/
def scalarPart {sig : CliffordSignature} (u : Multivector sig) : Int :=
  u.components (zeroIdx sig)

end Paritas.HodgeClifford
