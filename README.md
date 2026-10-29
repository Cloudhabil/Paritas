# Paritas

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.14.0-blue.svg)](https://leanprover.github.io/)
[![CI](https://github.com/cloudhabil/Paritas/actions/workflows/ci.yml/badge.svg)](https://github.com/cloudhabil/Paritas/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/license-Apache--2.0-green.svg)](LICENSE)
[![Axioms](https://img.shields.io/badge/custom_axioms-0-brightgreen.svg)]()
[![Sorry](https://img.shields.io/badge/sorry-0-brightgreen.svg)]()

**Paritas** is a self-contained, formally verified Lean 4 mathematical library standardizing Directed Acyclic Cell Complexes (DACC), Hodge-Clifford Spatial Transformers (HCST), Totally Non-Negative Grassmannians, 8D Solid-State Clifford Manifolds ($M^8$), and Discrete Topological Mechanics.

Developed by the **ToposLang / PLQ / TMMSL** initiative, `Paritas` provides an industrial-grade, constructive mathematical foundation with **zero external dependencies** and **zero unproven axioms**.

---

## Architecture Overview

```
                                      Paritas.lean
                                           │
         ┌───────────────────┬─────────────┴───────┬──────────────────┬─────────────────┬──────────────────┐
         ▼                   ▼                     ▼                  ▼                 ▼                  ▼
    Paritas.DACC     Paritas.HodgeClifford  Paritas.Grassmannian  Paritas.Manifold8D  Paritas.Mechanics  Paritas.Quantum
         │                   │                     │                  │                 │                  │
    ┌────┴────┐         ┌────┴────────┐            │             ┌────┴────┐            │             ┌────┴─────┐
    ▼         ▼         ▼    ▼        ▼            ▼             ▼         ▼            ▼             ▼          ▼
  Basic    Laplacian  Basic Dirac Projectors     Basic         Basic    Triality   MaxwellCalladine Tomography Kauffman
  Duality             Attention
```

---

## Formalized Modules & Verified Theorems

### 1. `Paritas.DACC` — Directed Acyclic Cell Complexes & Parity Duality
- **4-Tier Nilpotency**: Graded complexes $K = K_0 \sqcup K_1 \sqcup K_2 \sqcup K_3 \sqcup K_4$ satisfying $B_1 B_2 = 0$, $B_2 B_3 = 0$, $B_3 B_4 = 0$.
- **Universal Parity Symmetry** (`dacc_parity_coupling_symmetric`): Proves that for *any* incidence operator $B$, the self-coupling $I = B + B^T$ is symmetric under transposition ($I^T = I$).
- **$E_8$ Dynkin DAG Plumbing Instantiation** (`e8_dacc_parity_instantiation`): Constructive certification that the $8 \times 8$ $E_8$ Cartan intersection matrix is identically the DACC Parity Coupling $I_{E_8} = B_{\text{dacc}} + B_{\text{dacc}}^T$ of the directed Dynkin tree.
- **Discrete Hodge Laplacians** (`laplacian1_self_adjoint`): Proof that $L_1 = B_1^T B_1 + B_2 B_2^T$ is self-adjoint ($L_1^T = L_1$).

### 2. `Paritas.HodgeClifford` — Hodge-Clifford Spatial Transformers (HCST)
- **Kähler-Dirac Operator** (`hodge_dirac_self_adjoint`): $D = B + B^T$ is self-adjoint ($D^T = D$) with $D^2 = L$.
- **4D Clifford Hodge Star Involution** (`hodge_star_is_involution`): $\star_{\text{Cl}} \cdot \star_{\text{Cl}} = I_6$ on the 6D bivector space $\Lambda^2(\mathbb{R}^4)$.
- **Chiral Projector Idempotency** (`self_dual_projector_idempotent`): $(2 P_+)^2 = 2 (2 P_+)$ for $2 P_+ = I_6 + \star_{\text{Cl}}$.
- **Chiral Orthogonality** (`self_dual_anti_self_dual_orthogonal`): $(2 P_+) \cdot (2 P_-) = 0$.
- **Chiral Completeness** (`chiral_projector_completeness`): $2 P_+ + 2 P_- = 2 I_6$.
- **Akbulut Cork-Twist Sensitivity** (`cork_energy_shift_certified`): Breaking linear Hodge blindness with strictly positive non-linear self-dual energy $\Delta E_{\text{SD}} = 4 > 0$.
- **Dual-Stream Clifford Attention** (`attention_collinear_wedge_zero`, `attention_wedge_penalty_decreases`): Unifies Grade-0 metric scalar alignment with exterior wedge steric cancellation penalty $E_{ij} = \langle Q \widetilde{K} \rangle_0 - \lambda_\wedge |Q \wedge K|^2$.
- **Equivariant Motor Projections** (`identity_motor_invariant`): Unit rotor / motor sandwich transformations $T_M(A) = M A \widetilde{M}$.

### 3. `Paritas.Grassmannian` — Totally Non-Negative Grassmannian $\mathfrak{G}_{k,n}^{\ge 0}$
- **Plücker Blades**: Association of Grassmannian generators with simple decomposable Clifford $k$-blades.
- **Postnikov Path-Integral Inversion** (`postnikov_nilpotent_inverse_order2`): Exact finite algebraic inversion of acyclic DACC boundary measurements:
  $$(I - A) \cdot (I + A) = I \qquad \text{for strictly upper-triangular } A$$

### 4. `Paritas.Manifold8D` — 8D Solid-State Clifford Manifold $M^8$ & Spin(8) Triality
- **256-Blade Stalk Dimension** (`stalk_dim_eq_256`): Proof that $\dim \mathrm{Cl}(8,0,0) = 2^8 = 256$.
- **Binomial Grade Decomposition** (`stalk_grade_decomposition`):
  $$1 + 8 + 28 + 56 + 70 + 56 + 28 + 8 + 1 = 256$$
- **Reversion Involution** (`reversion_sign_sq`, `reversion_sign_table`): Involutivity of blade reversion $\widetilde{e}_I = (-1)^{k(k-1)/2} e_I$ across all grades $0 \le k \le 8$.
- **Katalepsis Inversa**: Exact algebraic blade inversion $Q^* = \widetilde{K} / \langle K \widetilde{K} \rangle_0$ with scalar alignment.
- **Spin(8) Triality Equidimensionality** (`spin8_triality_equidimensional`):
  $$\dim V_8 = \dim \mathbb{S}_8^+ = \dim \mathbb{S}_8^- = 8$$
- **Adjoint Bivector Dimension** (`so8_adjoint_dim_28`): $\dim \mathfrak{so}(8) = \binom{8}{2} = 28$.
- **$E_8$ Root Basis Gram Matrix** (`e8_cartan_diagonal_pos`, `e8_gram_diagonal`): Diagonal positivity certifying ground-state stability with signature $\sigma = 8$.

### 5. `Paritas.Mechanics` — Discrete Topological Mechanics
- **Maxwell–Calladine Index Theorem** (`maxwell_calladine_index_theorem`): Constructive proof that the topological index equals the degree of freedom deficit:
  $$\nu = N_0 - N_{ss} = \dim\ker C - \dim\ker C^T = d \cdot N_v - N_b$$
- **Mode Non-Negativity** (`maxwell_modes_nonneg`): Both floppy modes $N_0 \ge 0$ and states of self-stress $N_{ss} \ge 0$.
- **Isostatic Stability Criterion** (`isostatic_criterion_iff`): A framework is marginally stable (isostatic) if and only if $d \cdot N_v = N_b$ ($\langle z \rangle = 2d$).
- **Benchmark Certifications**:
  - 2D Isostatic Triangle (`triangle_certified`): $d=2, N_v=3, N_b=3 \implies \nu = 3$.
  - 2D Kagome Periodic Unit Cell (`kagome_isostatic_certified`): $d=2, N_v=3, N_b=6 \implies \nu = 0$, isostatic $\langle z \rangle = 4 = 2d$.
  - Boundary Nilpotency (`kagome_cell_nilpotency`): $B_1 \cdot B_2 = 0$.

### 6. `Paritas.Quantum` — Quantum Phase Space, MUBs, & Skein Invariants
- **Discrete Symplectic Phase Space** (`symplectic_skew_symmetric`, `symplectic_self_orthogonal`): Skew-symmetry $\Omega(u, v) = -\Omega(v, u)$ and isotropy $\Omega(u, u) = 0$ on $\mathbb{Z}_d \times \mathbb{Z}_d$.
- **Mutually Unbiased Bases (MUBs)** (`qubit_mub_count`, `qutrit_mub_count`): $d + 1$ MUBs in prime dimensions ($d=2 \implies 3$ MUBs, $d=3 \implies 4$ MUBs).
- **SIC-POVM Tight Frames & Zero-Inversion Tomography** (`qubit_sic_tetrahedron`, `sic_trace_reconstruction`): $d^2$ equiangular projectors with overlap $\frac{1}{d+1}$ and exact linear state reconstruction:
  $$\rho = (d + 1) \sum_{j=1}^{d^2} p_j \Pi_j - \mathbb{I}_d, \qquad \mathrm{Tr}(\rho) = (d + 1) \cdot 1 - d = 1$$
- **Kauffman Bracket Skein Algebra** (`kauffman_skein_zero`, `unknot_disjoint_identity`): Link diagrams with Skein relation $\langle L \rangle = A \langle L_0 \rangle + B \langle L_\infty \rangle$ and unknot elimination.

---

## Soundness & Axiom Audit

Every single definition and theorem in `Paritas` is machine-checked in pure Lean 4.
The `#print axioms` audit confirms:

```lean
#print axioms Paritas.DACC.dacc_parity_coupling_symmetric
-- depends on axioms: [propext, Quot.sound]

#print axioms Paritas.DACC.e8_dacc_parity_instantiation
-- depends on axioms: [propext, Quot.sound]

#print axioms Paritas.HodgeClifford.hodge_star_is_involution
-- depends on axioms: [propext]

#print axioms Paritas.HodgeClifford.self_dual_projector_idempotent
-- depends on axioms: [propext]

#print axioms Paritas.Grassmannian.postnikov_nilpotent_inverse_order2
-- depends on axioms: [propext, Quot.sound]

#print axioms Paritas.Manifold8D.spin8_triality_equidimensional
-- does not depend on any axioms

#print axioms Paritas.Mechanics.maxwell_calladine_index_theorem
-- depends on axioms: [propext, Quot.sound]
```

- **Custom Axioms**: `0`
- **`sorry` Placeholders**: `0`
- **Dependencies**: Lean 4 core only (`leanprover/lean4:v4.14.0`). No Mathlib build delays.

---

## Installation & Usage

Add `Paritas` to your `lakefile.lean`:

```lean
require paritas from git
  "https://github.com/cloudhabil/Paritas" @ "main"
```

Or for local development:

```lean
require paritas from "path/to/Paritas"
```

Import in your Lean 4 source:

```lean
import Paritas

open Paritas.DACC
open Paritas.HodgeClifford
open Paritas.Grassmannian
open Paritas.Manifold8D
open Paritas.Mechanics
open Paritas.Quantum
```

Build with Lake:

```bash
lake build
```

---

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.
