import Lake
open Lake DSL

package «paritas» where
  version := v!"0.1.0"
  keywords := #["topology", "clifford-algebra", "dacc", "discrete-morse", "quantum-physics"]
  description := "Paritas: Standardized Directed Acyclic Cell Complexes (DACC), Hodge-Clifford Spatial Transformers (HCST), and Discrete Topological Physics in Lean 4"
  homepage := "https://github.com/ToposLang/paritas"
  license := "Apache-2.0"
  licenseFiles := #["LICENSE"]

lean_lib «Paritas» where
  roots := #[`Paritas]
