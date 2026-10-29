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

import Paritas.HodgeClifford.Basic

/-!
# Paritas.HodgeClifford.Attention
## Dual-Stream Clifford Attention & Equivariant Motor Projections

This module formalizes the **Dual-Stream Clifford Attention** kernel from HCST:

$$E_{ij} = \frac{1}{\sqrt{2^d}} \left(\langle Q_i \widetilde{K}_j \rangle_0 - \lambda_\wedge |Q_i \wedge K_j|_{\mathrm{Cl}}^2\right)$$

combining metric scalar alignment ($\langle \cdot \rangle_0$) with geometric / steric wedge
cancellation ($|Q \wedge K|^2$), together with the Equivariant Rotor / Motor sandwich projection:

$$A' = M A \widetilde{M}$$
-/

namespace Paritas.HodgeClifford

/-- Dual-Stream Clifford Attention parameters:
    - `lambda_wedge`: Integer-scaled weight parameter for steric wedge cancellation $\lambda_\wedge \ge 0$.
    - `metric_align`: Scalar product alignment $\langle Q \widetilde{K} \rangle_0$.
    - `wedge_norm2`: Squared Clifford norm of the exterior wedge product $|Q \wedge K|_{\mathrm{Cl}}^2$.
-/
def computeAttentionScore (lambda_wedge metric_align wedge_norm2 : Int) : Int :=
  metric_align - lambda_wedge * wedge_norm2

/-- THEOREM (Vanishing Wedge Reduction):
    For collinear / parallel blades where the exterior wedge product vanishes ($Q \wedge K = 0$),
    the attention score reduces identically to the scalar metric alignment:
      E = ⟨Q ~K⟩₀. -/
theorem attention_collinear_wedge_zero (lambda_wedge metric_align : Int) :
    computeAttentionScore lambda_wedge metric_align 0 = metric_align := by
  dsimp [computeAttentionScore]
  omega

/-- THEOREM (Steric Penalty Monotonicity):
    Increasing geometric steric interference ($w_1 \le w_2$) with non-negative coupling
    $\lambda_\wedge \ge 0$ monotonically decreases the attention coupling score:
      E(w₂) ≤ E(w₁). -/
theorem attention_wedge_penalty_decreases (lambda_wedge metric_align w1 w2 : Int)
    (h_pos : 0 ≤ lambda_wedge) (h_le : w1 ≤ w2) :
    computeAttentionScore lambda_wedge metric_align w2 ≤ computeAttentionScore lambda_wedge metric_align w1 := by
  dsimp [computeAttentionScore]
  have h_mul := Int.mul_le_mul_of_nonneg_left h_le h_pos
  omega

/-- Structure representing a unit motor / rotor M satisfying M · ~M = 1. -/
structure UnitMotor (α : Type) [Mul α] [OfNat α 1] where
  motor : α
  rev   : α
  unit_prop : motor * rev = 1

/-- Sandwich transformation: T_M(A) = M · A · ~M. -/
def sandwichTransform {α : Type} [Mul α] (M revM : α) (A : α) : α :=
  M * A * revM

/-- THEOREM (Identity Motor Invariance):
    The identity motor M = 1 leaves any multivector A invariant:
      T_1(A) = 1 · A · 1 = A. -/
theorem identity_motor_invariant {α : Type} [Mul α] [OfNat α 1]
    (h_mul_one : ∀ x : α, x * 1 = x) (h_one_mul : ∀ x : α, 1 * x = x) (A : α) :
    sandwichTransform (1 : α) (1 : α) A = A := by
  dsimp [sandwichTransform]
  rw [h_one_mul, h_mul_one]

end Paritas.HodgeClifford
