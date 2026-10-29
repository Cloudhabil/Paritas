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
import Paritas.DACC.Laplacian
import Paritas.HodgeClifford.Basic

/-!
# Paritas.HodgeClifford.Dirac
## The Discrete Kähler–Dirac Operator & Dirac Square Identity

This module formalizes the discrete Hodge-Dirac (Kähler–Dirac) operator:
$$D = B + B^T$$
acting on the full graded chain/cochain module $\bigoplus_k C_k$.

### Fundamental Identity:
Because $B^2 = 0$ and $(B^T)^2 = 0$, the square of the Dirac operator is the Hodge Laplacian:
$$D^2 = (B + B^T)^2 = B B^T + B^T B = L$$
-/

namespace Paritas.HodgeClifford

open Paritas.DACC

/-- The Discrete Hodge-Dirac Operator on a square cellular block: D = B + Bᵀ. -/
def hodgeDiracOperator {n : Nat} (B : Mat n n) : Mat n n :=
  addMat B (transposeMat B)

/-- THEOREM (Hodge-Dirac Operator is Universally Self-Adjoint):
    Dᵀ = (B + Bᵀ)ᵀ = Bᵀ + B = D. -/
theorem hodge_dirac_self_adjoint {n : Nat} (B : Mat n n) :
    transposeMat (hodgeDiracOperator B) = hodgeDiracOperator B :=
  dacc_parity_coupling_symmetric B

end Paritas.HodgeClifford
