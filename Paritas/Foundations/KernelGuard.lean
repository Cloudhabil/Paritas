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
# Paritas.Foundations.KernelGuard
## Kernel Axiomatic Parsimony and Epistemic Audit Guard

This module formalizes the mathematical theory of **Kernel Axiomatic Parsimony**.

In foundational constructive mathematics and proof verification, a formal mathematical system
is sound only to the extent that its theorem derivations depend strictly on the standard
logical axioms of the meta-theory:
1. `propext`: Propositional Extensionality.
2. `Classical.choice`: Axiom of Choice.
3. `Quot.sound`: Quotient Soundness.

Any reliance on unproven synthetic axioms (such as `sorryAx` or unchecked custom `axiom` declarations)
compromises proof-theoretic soundness.

### Mathematical Content:
1. `StandardAxiom`: Canonical enumeration of admitted foundational axioms in constructive Lean 4.
2. `AxiomAuditStatus`: Algebraic classification of an axiom dependency set (Clean vs Tainted).
3. `AuditCertificate`: Formal structure certifying that a mathematical declaration possesses zero stubs,
   zero custom axioms, and conforms strictly to standard core foundations.
4. `verifyAxiomSet`: Decidable verification procedure classifying axiom strings.
-/

namespace Paritas.Foundations

/-- Canonical enumeration of the standard foundational axioms of Lean 4. -/
inductive StandardAxiom : Type
  | propext
  | classicalChoice
  | quotSound
deriving DecidableEq, Repr

/-- Mapping from standard axiom constructors to canonical Lean kernel identifiers. -/
def StandardAxiom.toKernelName : StandardAxiom → String
  | StandardAxiom.propext => "propext"
  | StandardAxiom.classicalChoice => "Classical.choice"
  | StandardAxiom.quotSound => "Quot.sound"

/-- Decidable predicate verifying whether a kernel axiom name is an admitted standard axiom. -/
def isStandardKernelAxiom (name : String) : Bool :=
  name == "propext" || name == "Classical.choice" || name == "Quot.sound"

/-- Audit status classification for formal declarations. -/
inductive AxiomAuditStatus : Type
  | verifiedClean
  | stubDetected (stubName : String)
  | nonStandardAxiomDetected (axiomName : String)
deriving DecidableEq, Repr

/-- Evaluates an array of kernel axiom dependencies against the standard core set. -/
def auditKernelAxioms (axioms : List String) : AxiomAuditStatus :=
  match axioms with
  | [] => AxiomAuditStatus.verifiedClean
  | ax :: rest =>
      if ax == "sorryAx" then
        AxiomAuditStatus.stubDetected ax
      else if isStandardKernelAxiom ax then
        auditKernelAxioms rest
      else
        AxiomAuditStatus.nonStandardAxiomDetected ax

/-- Formal certificate confirming that a named mathematical declaration is verified clean. -/
structure AuditCertificate where
  declarationName : String
  kernelAxioms : List String
  status : AxiomAuditStatus
  is_verified : status = AxiomAuditStatus.verifiedClean

/-- THEOREM (Empty Axiom Set is Clean):
    A theorem depending on zero axioms (pure constructive logic) is unconditionally verified clean. -/
theorem empty_axioms_verified_clean :
    auditKernelAxioms [] = AxiomAuditStatus.verifiedClean := rfl

/-- THEOREM (Standard Trio is Clean):
    A theorem depending on the full standard trio [propext, Classical.choice, Quot.sound] is verified clean. -/
theorem standard_trio_verified_clean :
    auditKernelAxioms ["propext", "Classical.choice", "Quot.sound"] = AxiomAuditStatus.verifiedClean := rfl

/-- THEOREM (Stub Detection Rejection):
    Any declaration referencing `sorryAx` is immediately rejected with `stubDetected`. -/
theorem sorryAx_rejected (rest : List String) :
    auditKernelAxioms ("sorryAx" :: rest) = AxiomAuditStatus.stubDetected "sorryAx" := rfl

end Paritas.Foundations
