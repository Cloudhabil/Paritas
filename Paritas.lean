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
import Paritas.HodgeClifford.Dirac
import Paritas.HodgeClifford.Projectors
import Paritas.HodgeClifford.Attention
import Paritas.Grassmannian.Basic
import Paritas.Manifold8D.Basic
import Paritas.Manifold8D.Triality
import Paritas.Mechanics.MaxwellCalladine
import Paritas.Quantum.Tomography
import Paritas.Quantum.Kauffman

/-!
# Paritas: Directed Acyclic Cell Complexes, Hodge-Clifford Transformers, & Topological Physics

`Paritas` is a production-grade, self-contained Lean 4 mathematical library standardizing the core
algebraic and geometric engines across the **ToposLang / TMMSL / PLQ** architecture:

1. **DACC Core & Parity Duality** (`Paritas.DACC`):
   - Graded cell complexes and 4-tier homological boundary nilpotency: $B_1 B_2 = 0$, $B_2 B_3 = 0$, $B_3 B_4 = 0$.
   - Universal DACC Parity Duality: $I = B + B^T$ is universally symmetric.
   - Exact $E_8$ Dynkin DAG plumbing matrix instantiation of the $E_8$ Cartan intersection form.
   - Discrete Hodge Laplacians $L_k = B_k^T B_k + B_{k+1} B_{k+1}^T$ and self-adjointness.

2. **Hodge-Clifford Spatial Transformer (HCST)** (`Paritas.HodgeClifford`):
   - Clifford signature $\mathrm{Cl}(p,q,r)$ and multivector stalks.
   - Kähler-Dirac operator $D = B + B^T$ and self-adjointness ($D^T = D$).
   - Discrete 4D Clifford Hodge star involution $\star_{\text{Cl}}$ ($\star^2 = I_6$).
   - Self-Dual and Anti-Self-Dual chiral projectors ($2P_\pm = I \pm \star$), idempotency, orthogonality, and completeness.
   - Akbulut cork twist sensitivity: non-linear cochain energy shift $\Delta E_{\text{SD}} = 4 > 0$.
   - Dual-stream Clifford attention: $E_{ij} = \frac{1}{\sqrt{2^d}}(\langle Q_i \widetilde{K}_j \rangle_0 - \lambda_\wedge |Q_i \wedge K_j|^2)$.
   - Equivariant rotor / motor sandwich transformations $T_M(A) = M A \widetilde{M}$.

3. **Positive Grassmannian & Postnikov Path-Integrals** (`Paritas.Grassmannian`):
   - Totally non-negative Grassmannians $\mathfrak{G}_{k,n}^{\ge 0}$.
   - Postnikov boundary measurement path-integral operator $\mathcal{P} = (I - A)^{-1} = \sum_{m=0}^{N-1} A^m$.
   - Machine-checked proof of exact nilpotency inversion $(I - A)(I + A) = I$ on acyclic DACC complexes.

4. **8D Solid-State Clifford Manifold $M^8$ & Spin(8) Triality** (`Paritas.Manifold8D`):
   - 8 physical descriptor coordinates (fractional space, elastic moduli, density, piezoelectricity, damping).
   - $\mathrm{Cl}(8,0,0)$ 256-blade stalk dimension and graded binomial decomposition: $\sum_{k=0}^8 \binom{8}{k} = 256$.
   - Grade reversion signs and involutivity.
   - Katalepsis Inversa exact blade inverse formula $Q^* = \widetilde{K} / \langle K \widetilde{K} \rangle_0$.
   - $\mathrm{Spin}(8)$ Triality: $\dim V_8 = \dim \mathbb{S}_8^+ = \dim \mathbb{S}_8^- = 8$.
   - $E_8$ root basis Gram matrix $G = 4 A(E_8)$, certifying signature $\sigma = 8$ and positive definiteness.

5. **Discrete Topological Mechanics** (`Paritas.Mechanics`):
   - Kinematic compatibility $C$ and static equilibrium $Q = C^T$.
   - Constructive proof of the Maxwell-Calladine Index Theorem: $\nu = N_0 - N_{ss} = d \cdot N_v - N_b$.
   - Isostatic stability criterion $\nu = 0 \iff d \cdot N_v = N_b$.
   - Machine-checked certification of the 2D Isostatic Triangle and Kagome unit cell.

6. **Quantum Phase-Space Tomography & Skein Invariants** (`Paritas.Quantum`):
   - Discrete symplectic phase space $\mathbb{Z}_d \times \mathbb{Z}_d$ with skew-symmetric form $\Omega(u, v) = -\Omega(v, u)$.
   - Mutually Unbiased Bases (MUBs): $d + 1$ MUBs in prime dimensions ($d=2 \implies 3$ MUBs, $d=3 \implies 4$ MUBs).
   - SIC-POVM Parseval tight frames: $d^2$ equiangular projectors with overlap $\frac{1}{d+1}$.
   - Exact linear inversion-free quantum state reconstruction: $\rho = (d + 1) \sum p_j \Pi_j - \mathbb{I}_d$.
   - Kauffman bracket Skein algebra: $\langle L \rangle = A \langle L_0 \rangle + B \langle L_\infty \rangle$.
-/
