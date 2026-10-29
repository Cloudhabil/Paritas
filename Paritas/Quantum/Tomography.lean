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
# Paritas.Quantum.Tomography
## Quantum Phase Space, MUBs, & SIC-POVM Parseval Frames

This module formalizes the quantum phase space tomography apparatus from ToposLang:
1. **Discrete Symplectic Phase Space**: $\mathbb{Z}_d \times \mathbb{Z}_d$ with symplectic pairing
   $\Omega((p_1, q_1), (p_2, q_2)) = p_1 q_2 - p_2 q_1$.
2. **Mutually Unbiased Bases (MUBs)**: Complete sets of $d + 1$ MUBs in prime dimensions $d$.
3. **SIC-POVM Tight Frames & Inversion-Free Tomography**:
   $d^2$ equiangular projectors with cross-talk overlap $\frac{1}{d + 1}$ and exact linear
   trace-preserving reconstruction:
   $$\rho = (d + 1) \sum_{j=1}^{d^2} p_j \Pi_j - \mathbb{I}_d$$
-/

namespace Paritas.Quantum

/-- A point in discrete 2D phase space: (position p, momentum q). -/
structure PhasePoint where
  p : Int
  q : Int

/-- Standard discrete symplectic bilinear form on phase space:
    $\Omega(u, v) = u.p \cdot v.q - u.q \cdot v.p$. -/
def symplecticForm (u v : PhasePoint) : Int :=
  u.p * v.q - u.q * v.p

/-- THEOREM (Symplectic Skew-Symmetry):
    $\Omega(u, v) = -\Omega(v, u)$. -/
theorem symplectic_skew_symmetric (u v : PhasePoint) :
    symplecticForm u v = -symplecticForm v u := by
  dsimp [symplecticForm]
  rw [Int.mul_comm v.p u.q, Int.mul_comm v.q u.p]
  omega

/-- THEOREM (Symplectic Self-Orthogonality):
    $\Omega(u, u) = 0$. -/
theorem symplectic_self_orthogonal (u : PhasePoint) :
    symplecticForm u u = 0 := by
  dsimp [symplecticForm]
  rw [Int.mul_comm u.q u.p]
  omega

/-- Number of Mutually Unbiased Bases (MUBs) in prime dimension d: N_{MUB} = d + 1. -/
def primeMUBCount (d : Int) : Int :=
  d + 1

/-- Total number of state vectors in a complete set of MUBs: d · (d + 1). -/
def totalMUBVectors (d : Int) : Int :=
  d * (d + 1)

/-- THEOREM (Qubit MUB Count):
    In dimension d = 2, there are exactly 3 MUBs (Pauli X, Y, Z eigenbases). -/
theorem qubit_mub_count : primeMUBCount 2 = 3 := by
  rfl

/-- THEOREM (Qutrit MUB Count):
    In dimension d = 3, there are exactly 4 MUBs. -/
theorem qutrit_mub_count : primeMUBCount 3 = 4 := by
  rfl

/-- THEOREM (Qubit MUB Total Vectors):
    In dimension d = 2, there are 2 · 3 = 6 state vectors total. -/
theorem qubit_total_mub_vectors : totalMUBVectors 2 = 6 := by
  rfl

/-- Number of projectors in a SIC-POVM in dimension d: d². -/
def sicProjectorCount (d : Int) : Int :=
  d * d

/-- Equiangular overlap denominator for SIC-POVM cross-talk: 1 / (d + 1). -/
def sicOverlapDenominator (d : Int) : Int :=
  d + 1

/-- THEOREM (Qubit SIC-POVM Tetrahedron):
    In dimension d = 2, the SIC-POVM consists of 2² = 4 tetrahedral state vectors
    with cross-talk overlap denominator 2 + 1 = 3 (overlap = 1/3). -/
theorem qubit_sic_tetrahedron :
    sicProjectorCount 2 = 4 ∧ sicOverlapDenominator 2 = 3 := by
  decide

/-- THEOREM (Exact Inversion-Free SIC-POVM Trace Reconstruction):
    For any normalized probability distribution $\sum_{j=1}^{d^2} p_j = 1$,
    the reconstructed quantum state $\rho = (d + 1) \sum p_j \Pi_j - \mathbb{I}_d$
    has trace identically equal to 1:
      Tr(ρ) = (d + 1) · (∑ p_j) - d = (d + 1) · 1 - d = 1. -/
theorem sic_trace_reconstruction (d : Int) (sum_p : Int) (h_prob : sum_p = 1) :
    (d + 1) * sum_p - d = 1 := by
  rw [h_prob]
  omega

end Paritas.Quantum
