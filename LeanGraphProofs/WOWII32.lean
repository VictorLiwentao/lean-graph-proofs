/-
Copyright 2026 The Formal Conjectures Authors.
Copyright (c) 2026 Wentao Li.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/
import LeanGraphProofs.Support.VertexDistance
import Mathlib.Combinatorics.SimpleGraph.Diam
import Mathlib.Combinatorics.SimpleGraph.Hasse
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# WOWII 32: the known five-vertex path counterexample

Human author: Wentao Li. AI assistance: Codex GPT-6.1 Sol.
The counterexample is credited to the original WOWII source authors as recorded in
`FormalConjectures/WrittenOnTheWallII/GraphConjecture32.lean` at frozen commit
`86daeae6fa80d23eb32bb610aa499ce88180c5a5`.

Sources:
- https://cms.uhd.edu/faculty/delavinae/research/wowII/
- https://github.com/google-deepmind/formal-conjectures/pull/5729
-/

namespace WOWII32

open SimpleGraph

/-- The path with edges 0–1–2–3–4. -/
abbrev P5 : SimpleGraph (Fin 5) := pathGraph 5

instance : DecidableRel P5.Adj := fun u v =>
  decidable_of_iff (u.val + 1 = v.val ∨ v.val + 1 = u.val) pathGraph_adj.symm

/-- The witness satisfies the exact connectivity hypothesis. -/
theorem p5_connected : P5.Connected := pathGraph_connected 4

/-- The complete distance matrix, checked through the proved BFS API. -/
theorem p5_dist (u v : Fin 5) : P5.dist u v = u.val - v.val + (v.val - u.val) := by
  rw [dist_eq_computable]
  have h : ∀ u v : Fin 5,
      computable_dist P5 u v = u.val - v.val + (v.val - u.val) := by decide
  exact h u v

/-- Minimum-degree vertices are exactly the endpoints. -/
theorem p5_min_vertices :
    Finset.univ.filter (fun v => P5.degree v = P5.minDegree) = {0, 4} := by decide

/-- Maximum-degree vertices are exactly the three interior vertices. -/
theorem p5_max_vertices :
    Finset.univ.filter (fun v => P5.degree v = P5.maxDegree) = {1, 2, 3} := by decide

/-- The eccentricity of any witness vertex, including the three used in the mean. -/
theorem p5_eccent (u : Fin 5) : P5.eccent u = (max u.val (4 - u.val) : ℕ) := by
  apply le_antisymm
  · rw [eccent_le_iff]
    intro v
    rw [← (p5_connected u v).coe_dist_eq_edist, p5_dist]
    exact_mod_cast (show u.val - v.val + (v.val - u.val) ≤ max u.val (4 - u.val) by
      omega)
  · have h0 := P5.edist_le_eccent (u := u) (v := 0)
    have h4 := P5.edist_le_eccent (u := u) (v := 4)
    rw [← (p5_connected u 0).coe_dist_eq_edist, p5_dist] at h0
    rw [← (p5_connected u 4).coe_dist_eq_edist, p5_dist] at h4
    fin_cases u <;> norm_num at * <;> assumption

/-- Every induced path uses at most the ambient number of vertices. -/
theorem path_le_card {α : Type*} [Fintype α] [DecidableEq α] (G : SimpleGraph α) :
    path G ≤ Fintype.card α := by
  classical
  let s : Finset (Finset α) := Finset.univ.filter (fun t =>
    ∃ l : List α, l.toFinset = t ∧ isInducedPath G l)
  change (s.image Finset.card).max.getD 0 ≤ Fintype.card α
  have hmax : (s.image Finset.card).max ≤ (Fintype.card α : WithBot ℕ) := by
    apply Finset.max_le_iff.mpr
    intro n hn
    obtain ⟨t, _, rfl⟩ := Finset.mem_image.mp hn
    exact WithBot.coe_le_coe.mpr (Finset.card_le_univ t)
  cases hm : (s.image Finset.card).max with
  | bot => exact Nat.zero_le _
  | coe n => exact WithBot.coe_le_coe.mp (hm ▸ hmax)

/-- The corrected proposed lower bound on P₅ is 16/3, which exceeds every induced path. -/
theorem p5_counterexample :
    let A : Finset (Fin 5) := Finset.univ.filter (fun v => P5.degree v = P5.minDegree)
    let M : Finset (Fin 5) := Finset.univ.filter (fun v => P5.degree v = P5.maxDegree)
    let distavgA : ℝ := (∑ p ∈ A.offDiag, (P5.dist p.1 p.2 : ℝ)) / (A.offDiag.card : ℝ)
    let eccavg (S : Finset (Fin 5)) : ℝ :=
      (∑ v ∈ S, (P5.eccent v).toNat) / (S.card : ℝ)
    ¬ (distavgA + (1 / 2 : ℝ) * eccavg M ≤ (path P5 : ℝ)) := by
  dsimp only
  rw [p5_min_vertices, p5_max_vertices]
  have hp : (path P5 : ℝ) ≤ 5 := by
    exact_mod_cast (show path P5 ≤ 5 from path_le_card P5)
  have pairs : ({0, 4} : Finset (Fin 5)).offDiag = {(0, 4), (4, 0)} := by decide
  rw [pairs]
  simp [Finset.sum_insert, p5_dist, p5_eccent]
  norm_num
  linarith

/-- The complete frozen universal assertion is false. -/
theorem conjecture32 : False ↔
    ∀ (α : Type) [Fintype α] [DecidableEq α] [Nontrivial α]
      (G : SimpleGraph α) [DecidableRel G.Adj] (_h : G.Connected),
      let A : Finset α := Finset.univ.filter (fun v => G.degree v = G.minDegree)
      let M : Finset α := Finset.univ.filter (fun v => G.degree v = G.maxDegree)
      let distavgA : ℝ := (∑ p ∈ A.offDiag, (G.dist p.1 p.2 : ℝ)) / (A.offDiag.card : ℝ)
      let eccavg (S : Finset α) : ℝ := (∑ v ∈ S, (G.eccent v).toNat) / (S.card : ℝ)
      distavgA + (1 / 2 : ℝ) * eccavg M ≤ (path G : ℝ) := by
  constructor
  · exact False.elim
  · intro h
    exact p5_counterexample (h (Fin 5) P5 p5_connected)


end WOWII32
