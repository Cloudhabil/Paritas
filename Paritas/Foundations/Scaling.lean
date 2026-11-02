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
# Paritas.Foundations.Scaling
## Degree-Homogeneous Multilinear Bounds and Scaling Equivariance

This module formalizes the mathematical theory of **Degree-Homogeneous Scaling Bounds**
for multilinear correlation functionals.

In Euclidean quantum field theory and the Osterwalder-Schrader (OS-0) reconstruction axioms,
the $n$-point correlation functions $S_n(f_1, \dots, f_n)$ are multilinear forms of degree $n$.
Under field rescaling $\Phi \mapsto c \Phi$, the correlation function scales homogeneously as
$S_n \mapsto c^n S_n$.

Consequently, any tempered growth bound on generating multiplets must reflect this multilinear
degree scaling: the prefactor must scale exponentially with degree as $\alpha^n (n!)^\beta$, rather
than being a degree-independent constant $\alpha (n!)^\beta$.

### Mathematical Content:
1. `MultilinearFamily`: Family of $n$-point functionals indexed by degree $n \in \mathbb{N}$.
2. `DegreeHomogeneousBound`: Certified growth bound enforcing prefactor $\alpha^n (n!)^\beta$.
3. `degree_homogeneous_compounding`: Theorem proving that the product of degree-$n$ and degree-$m$
   homogeneous bounds compounds multiplicatively as $\alpha^{n + m}$.
4. `factorial_le_factorial_add`: Arithmetic property $(n!) (m!) \le (n + m)!$.
-/

namespace Paritas.Foundations

/-- Canonical factorial function on natural numbers. -/
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

@[simp] theorem factorial_zero : factorial 0 = 1 := rfl
@[simp] theorem factorial_succ (n : Nat) : factorial (n + 1) = (n + 1) * factorial n := rfl

/-- Commutativity rearrangement lemma for 4-fold multiplication. -/
theorem mul_mul_mul_comm (a b c d : Nat) : (a * b) * (c * d) = (a * c) * (b * d) := by
  rw [Nat.mul_assoc a b (c * d)]
  rw [← Nat.mul_assoc b c d]
  rw [Nat.mul_comm b c]
  rw [Nat.mul_assoc c b d]
  rw [← Nat.mul_assoc a c (b * d)]

/-- Commutativity rearrangement lemma for 3-fold multiplication with a scalar. -/
theorem mul_comm_assoc3 (a b c : Nat) : a * (b * c) = b * (a * c) := by
  rw [← Nat.mul_assoc a b c]
  rw [Nat.mul_comm a b]
  rw [Nat.mul_assoc b a c]

/-- Arithmetic theorem: $n! \cdot m! \le (n + m)!$ across all natural degrees. -/
theorem factorial_le_factorial_add (n m : Nat) :
    factorial n * factorial m ≤ factorial (n + m) := by
  induction m with
  | zero =>
      dsimp [factorial]
      rw [Nat.mul_one]
      exact Nat.le_refl _
  | succ m' ih =>
      rw [Nat.add_succ]
      dsimp [factorial]
      have hle : m' + 1 ≤ n + m' + 1 := by omega
      have h1 : (m' + 1) * (factorial n * factorial m') ≤
                (n + m' + 1) * factorial (n + m') := by
        exact Nat.mul_le_mul hle ih
      rw [mul_comm_assoc3 (factorial n) (m' + 1) (factorial m')]
      exact h1

/-- A family of $n$-point correlation bounds characterized by scaling parameter $\alpha$
    and Gevrey class regularity index $\beta$. -/
structure DegreeHomogeneousBound where
  alpha : Nat
  beta : Nat
  alpha_pos : alpha > 0

/-- Canonical bound value at degree $n$ and total argument norm $N$:
    $\text{bound}(n, N) = \alpha^n \cdot (n!)^\beta \cdot N$. -/
def boundValue (B : DegreeHomogeneousBound) (n norm : Nat) : Nat :=
  (B.alpha ^ n) * ((factorial n) ^ B.beta) * norm

/-- THEOREM (Exponential Degree Factorization):
    The exponential prefactor $\alpha^n$ factors exactly over additive degrees:
    $\alpha^{n + m} = \alpha^n \cdot \alpha^m$. -/
theorem degree_exponential_add (B : DegreeHomogeneousBound) (n m : Nat) :
    B.alpha ^ (n + m) = B.alpha ^ n * B.alpha ^ m :=
  Nat.pow_add B.alpha n m

/-- Power monotonicity for natural numbers. -/
theorem nat_pow_le_pow_of_le {a b : Nat} (h : a ≤ b) (k : Nat) : a ^ k ≤ b ^ k := by
  induction k with
  | zero => exact Nat.le_refl _
  | succ k' ih =>
      rw [Nat.pow_succ, Nat.pow_succ]
      exact Nat.mul_le_mul ih h

/-- Multiplicativity of natural powers: $(a \cdot b)^k = a^k \cdot b^k$. -/
theorem nat_mul_pow (a b k : Nat) : (a * b) ^ k = a ^ k * b ^ k := by
  induction k with
  | zero => rfl
  | succ k' ih =>
      rw [Nat.pow_succ, Nat.pow_succ, Nat.pow_succ, ih]
      exact mul_mul_mul_comm (a ^ k') (b ^ k') a b

/-- THEOREM (Factorial Power Compounding):
    For any Gevrey index $\beta$, $(n!)^\beta \cdot (m!)^\beta \le ((n + m)!)^\beta$. -/
theorem factorial_power_compounding (beta n m : Nat) :
    (factorial n) ^ beta * (factorial m) ^ beta ≤ (factorial (n + m)) ^ beta := by
  rw [← nat_mul_pow]
  exact nat_pow_le_pow_of_le (factorial_le_factorial_add n m) beta

/-- Commutative rearrangement for 6 variables into 3 pairs:
    $(a \cdot b \cdot c) \cdot (d \cdot e \cdot f) = (a \cdot d) \cdot (b \cdot e) \cdot (c \cdot f)$. -/
theorem mul6_pairing (a b c d e f : Nat) :
    ((a * b) * c) * ((d * e) * f) = (((a * d) * (b * e)) * (c * f)) := by
  have h1 := mul_mul_mul_comm (a * b) c (d * e) f
  have h2 := mul_mul_mul_comm a b d e
  rw [h1, h2]

/-- THEOREM (Degree-Homogeneous Tensor Bound Compounding):
    The product of degree-$n$ and degree-$m$ bounds is bounded by the composite degree-$(n + m)$ bound:
    $\text{bound}(n, N_1) \cdot \text{bound}(m, N_2) \le \text{bound}(n + m, N_1 \cdot N_2)$. -/
theorem degree_homogeneous_compounding (B : DegreeHomogeneousBound) (n m N₁ N₂ : Nat) :
    boundValue B n N₁ * boundValue B m N₂ ≤ boundValue B (n + m) (N₁ * N₂) := by
  dsimp [boundValue]
  have h_alpha : B.alpha ^ n * B.alpha ^ m = B.alpha ^ (n + m) := (degree_exponential_add B n m).symm
  have h_fact := factorial_power_compounding B.beta n m
  have rearr := mul6_pairing (B.alpha ^ n) ((factorial n) ^ B.beta) N₁
                            (B.alpha ^ m) ((factorial m) ^ B.beta) N₂
  rw [rearr, h_alpha]
  have h_mid : (B.alpha ^ (n + m)) * ((factorial n) ^ B.beta * (factorial m) ^ B.beta) ≤
               (B.alpha ^ (n + m)) * ((factorial (n + m)) ^ B.beta) :=
    Nat.mul_le_mul_left (B.alpha ^ (n + m)) h_fact
  exact Nat.mul_le_mul_right (N₁ * N₂) h_mid

end Paritas.Foundations
