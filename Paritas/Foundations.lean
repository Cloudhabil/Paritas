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

import Paritas.Foundations.NonVacuity
import Paritas.Foundations.Generation
import Paritas.Foundations.Multiscale
import Paritas.Foundations.Scaling
import Paritas.Foundations.KernelGuard

/-!
# Paritas.Foundations
## Constructive Foundations, Epistemic Non-Vacuity, & Epistemic Audit Guard

This subsystem provides the formal mathematical foundation for **Epistemic Non-Vacuity**
and **Constructive Verification** within `Paritas`:

1. **Non-Vacuity & Realizability** (`Paritas.Foundations.NonVacuity`):
   - Precludes dummy models ($G = 0, \mathcal{H} = \{0\}$).
   - Formulates `ConstructiveWitness` bundles, forbidding ungrounded identity-forwarding hypotheses.
   - Formalizes positive spectral gaps $\Delta > 0$ with minimal vacuum energy.

2. **Universal Generator Grounding** (`Paritas.Foundations.Generation`):
   - Forbids decoupled abstract algebras (`Poly`, `LiePoly`) without physical generators.
   - Proves uniqueness theorem: endomorphisms agreeing on generators agree universally.

3. **Multiscale Inductive Grounding** (`Paritas.Foundations.Multiscale`):
   - Governs iterated block decimation towers $(ST)^k$.
   - Proves base-case recovery: compound decimation at $k = 1$ is definitionally congruent to the base lattice.

4. **Degree-Homogeneous Scaling** (`Paritas.Foundations.Scaling`):
   - Enforces multilinear scaling degree-homogeneity: bounds scale as $\alpha^n (n!)^\beta$.
   - Proves tensor compounding theorem for $n$-point correlation functionals.

5. **Kernel Axiomatic Parsimony** (`Paritas.Foundations.KernelGuard`):
   - Establishes certified audit status classifying declarations against core foundational axioms:
     `[propext, Classical.choice, Quot.sound]`.
   - Rejects stubs (`sorryAx`) and custom unproven axioms.
-/
