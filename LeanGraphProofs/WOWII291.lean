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
import LeanGraphProofs.Support.Degrees
import LeanGraphProofs.Support.Domination
import LeanGraphProofs.Support.Residue
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases

/-!
# Counterexample certificate for WOWII 291

Human author: Wentao Li. OpenAI Codex assisted with proof development.
The finite construction is the `m = 6` member documented by `vulnix0x4` in
https://github.com/google-deepmind/formal-conjectures/issues/4562 (July 23, 2026).
The upstream source credits the known disproof to Zyad Tamimi.
-/

/- Frozen target definitions, copied verbatim in value from the Apache 2.0 source. -/
namespace WrittenOnTheWallII.GraphConjecture291

open SimpleGraph

variable {α : Type*} [Fintype α] [DecidableEq α] [Nontrivial α]

noncomputable def minTrianglesAtVertex (G : SimpleGraph α) [DecidableRel G.Adj] : ℕ :=
  Finset.univ.inf' Finset.univ_nonempty (numTrianglesAtVertex G)

noncomputable def freqMinTriangles (G : SimpleGraph α) [DecidableRel G.Adj] : ℕ :=
  (Finset.univ.filter (fun v => numTrianglesAtVertex G v = minTrianglesAtVertex G)).card

noncomputable def descDegreeSequence (G : SimpleGraph α) [DecidableRel G.Adj] : List ℕ :=
  (Finset.univ.val.map (fun v : α => G.degree v)).sort (· ≥ ·)

noncomputable def havelHakimiIterate (G : SimpleGraph α) [DecidableRel G.Adj] (i : ℕ) :
    List ℕ :=
  (havelHakimiStep)^[i] (descDegreeSequence G)

noncomputable def havelHakimiZeroStep (G : SimpleGraph α) [DecidableRel G.Adj] : ℕ :=
  sInf {i | 0 ∈ havelHakimiIterate G i ∨ havelHakimiIterate G i = []}

end WrittenOnTheWallII.GraphConjecture291

namespace ResearchWOWII291

open SimpleGraph WrittenOnTheWallII.GraphConjecture291

/-- Vertex labels: `a, b, x₁, …, x₆, p, q, r, ℓ` correspond to `0, …, 11`. -/
def edges : Finset (Fin 12 × Fin 12) :=
  {(0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 9),
   (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8),
   (2, 8), (2, 9), (3, 4), (3, 10), (4, 10), (9, 11)}

/-- Bit rows for the documented edge list, avoiding repeated set construction. -/
def row : Fin 12 → ℕ :=
  ![766, 509, 771, 1043, 1035, 3, 3, 3, 6, 2053, 24, 512]

/-- The explicitly documented twelve-vertex witness. -/
def witness : SimpleGraph (Fin 12) where
  Adj i j := (row i).testBit j.val = true
  symm := ⟨by decide⟩
  loopless := ⟨by decide⟩

instance : DecidableRel witness.Adj := fun i j =>
  inferInstanceAs (Decidable ((row i).testBit j.val = true))

/-- The bit representation has exactly the source's undirected edges. -/
theorem edge_certificate : ∀ i j : Fin 12,
    witness.Adj i j ↔ (i, j) ∈ edges ∨ (j, i) ∈ edges := by
  decide

set_option maxRecDepth 8192
set_option maxHeartbeats 200000

/-- Every vertex is joined to vertex zero by at most two edges. -/
theorem witness_connected : witness.Connected := by
  have paths : ∀ v : Fin 12, v = 0 ∨ witness.Adj 0 v ∨
      ∃ w : Fin 12, witness.Adj 0 w ∧ witness.Adj w v := by decide
  apply (connected_iff_exists_forall_reachable witness).mpr
  refine ⟨0, fun v => ?_⟩
  rcases paths v with h | h | ⟨w, h, h'⟩
  · subst v
    exact Reachable.refl _
  · exact h.reachable
  · exact h.reachable.trans h'.reachable

/-- The degree sequence retains all degree multiplicities. -/
theorem degree_certificate : descDegreeSequence witness =
    [8, 8, 4, 4, 4, 3, 2, 2, 2, 2, 2, 1] := by
  unfold descDegreeSequence
  simp only [SimpleGraph.degree, neighborFinset_eq_filter]
  unfold Multiset.sort
  simp_rw [List.mergeSort_eq_insertionSort]
  decide

/-- Exact enumeration of the eleven triangles. -/
theorem clique_certificate : witness.cliqueFinset 3 =
    {{0, 1, 2}, {0, 1, 3}, {0, 1, 4}, {0, 1, 5}, {0, 1, 6}, {0, 1, 7},
     {1, 2, 8}, {0, 2, 9}, {0, 3, 4}, {1, 3, 4}, {3, 4, 10}} := by
  have restrict : witness.cliqueFinset 3 =
      (Finset.univ.powersetCard 3).filter
        (fun s : Finset (Fin 12) => witness.IsClique (s : Set (Fin 12))) := by
    ext s
    simp only [mem_cliqueFinset_iff, isNClique_iff, Finset.mem_filter,
      Finset.mem_powersetCard_univ]
    exact and_comm
  rw [restrict]
  decide

/-- The exact incident-triangle table for all twelve vertices. -/
def triangleCounts : Fin 12 → ℕ := ![8, 8, 3, 4, 4, 1, 1, 1, 1, 1, 1, 0]

theorem triangle_count_certificate (v : Fin 12) :
    numTrianglesAtVertex witness v = triangleCounts v := by
  unfold numTrianglesAtVertex
  rw [clique_certificate]
  fin_cases v <;> decide

/-- A triangle-free leaf certifies that the minimum incident count is zero. -/
theorem minimum_triangle_certificate : minTrianglesAtVertex witness = 0 := by
  apply Nat.eq_zero_of_le_zero
  unfold minTrianglesAtVertex
  calc
    Finset.univ.inf' Finset.univ_nonempty (numTrianglesAtVertex witness) ≤
        numTrianglesAtVertex witness 11 :=
      Finset.inf'_le _ (Finset.mem_univ (11 : Fin 12))
    _ = 0 := by rw [triangle_count_certificate]; rfl

/-- The leaf is the unique vertex attaining the minimum triangle count. -/
theorem frequency_certificate : freqMinTriangles witness = 1 := by
  simp only [freqMinTriangles, minimum_triangle_certificate, triangle_count_certificate]
  decide

/-- The first two reductions, with no zero before the second. -/
theorem hh_certificate :
    havelHakimiIterate witness 0 = [8, 8, 4, 4, 4, 3, 2, 2, 2, 2, 2, 1] ∧
    havelHakimiIterate witness 1 = [7, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1] ∧
    havelHakimiIterate witness 2 = [2, 2, 2, 1, 1, 1, 1, 1, 1, 0] := by
  have first : havelHakimiStep [8, 8, 4, 4, 4, 3, 2, 2, 2, 2, 2, 1] =
      [7, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1] := by
    simp only [havelHakimiStep, List.mergeSort_eq_insertionSort]
    decide
  have second : havelHakimiStep [7, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1] =
      [2, 2, 2, 1, 1, 1, 1, 1, 1, 0] := by
    simp only [havelHakimiStep, List.mergeSort_eq_insertionSort]
    decide
  simp only [havelHakimiIterate, degree_certificate, Nat.iterate, first, second,
    and_self]

/-- The first zero step is two, counting the initial sequence as step zero. -/
theorem zero_step_certificate : havelHakimiZeroStep witness = 2 := by
  have at_two : 0 ∈ havelHakimiIterate witness 2 ∨
      havelHakimiIterate witness 2 = [] := by
    rw [hh_certificate.2.2]
    decide
  unfold havelHakimiZeroStep
  apply (csInf_eq_iff ⟨2, at_two⟩ 2).mpr
  refine ⟨at_two, fun i hi => ?_⟩
  change 0 ∈ havelHakimiIterate witness i ∨ havelHakimiIterate witness i = [] at hi
  by_contra h
  have cases : i = 0 ∨ i = 1 := by omega
  rcases cases with rfl | rfl
  · rw [hh_certificate.1] at hi
    exact (by decide : ¬(0 ∈ [8, 8, 4, 4, 4, 3, 2, 2, 2, 2, 2, 1] ∨
      ([8, 8, 4, 4, 4, 3, 2, 2, 2, 2, 2, 1] : List ℕ) = [])) hi
  · rw [hh_certificate.2.1] at hi
    exact (by decide : ¬(0 ∈ [7, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1] ∨
      ([7, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1] : List ℕ) = [])) hi

/-- The four specified vertices totally dominate the witness. -/
theorem total_domination_upper : witness.IsTotalDominating
    ({0, 2, 3, 9} : Finset (Fin 12)) := by
  unfold IsTotalDominating
  decide

/-- Four neighborhood requirements force at least four selected vertices. -/
theorem total_domination_lower (D : Finset (Fin 12))
    (hD : witness.IsTotalDominating (D : Set (Fin 12))) : 4 ≤ D.card := by
  have neighborhoods :
      (∀ v : Fin 12, witness.Adj 11 v ↔ v = 9) ∧
      (∀ v : Fin 12, witness.Adj 5 v ↔ v = 0 ∨ v = 1) ∧
      (∀ v : Fin 12, witness.Adj 8 v ↔ v = 1 ∨ v = 2) ∧
      (∀ v : Fin 12, witness.Adj 9 v ↔ v = 0 ∨ v = 2 ∨ v = 11) ∧
      (∀ v : Fin 12, witness.Adj 10 v ↔ v = 3 ∨ v = 4) := by decide
  obtain ⟨q, hq, hqadj⟩ := hD 11
  have hq9 := (neighborhoods.1 q).mp hqadj
  subst q
  obtain ⟨r, hr, hradj⟩ := hD 10
  have hr34 := (neighborhoods.2.2.2.2 r).mp hradj
  obtain ⟨a, ha, haadj⟩ := hD 5
  have ha01 := (neighborhoods.2.1 a).mp haadj
  have count (b : Fin 12) (hb : b ∈ D)
      (hcard : 4 ≤ ({9, r, a, b} : Finset (Fin 12)).card) : 4 ≤ D.card := by
    apply hcard.trans
    apply Finset.card_le_card
    intro v hv
    simp only [Finset.mem_insert, Finset.mem_singleton] at hv
    rcases hv with rfl | rfl | rfl | rfl
    · exact hq
    · exact hr
    · exact ha
    · exact hb
  rcases ha01 with ha0 | ha1
  · subst a
    obtain ⟨b, hb, hbadj⟩ := hD 8
    have hb12 := (neighborhoods.2.2.1 b).mp hbadj
    apply count b hb
    rcases hr34 with rfl | rfl <;> rcases hb12 with rfl | rfl <;> decide
  · subst a
    obtain ⟨b, hb, hbadj⟩ := hD 9
    have hb0211 := (neighborhoods.2.2.2.1 b).mp hbadj
    apply count b hb
    rcases hr34 with rfl | rfl <;>
      rcases hb0211 with rfl | rfl | rfl <;> decide

/-- Total domination is exactly four. -/
theorem domination_certificate : witness.totalDominationNumber = 4 := by
  have four : ∃ D : Finset (Fin 12), witness.IsTotalNDominatingSet 4 D :=
    ⟨{0, 2, 3, 9}, total_domination_upper, by decide⟩
  unfold totalDominationNumber
  apply (csInf_eq_iff ⟨4, four⟩ 4).mpr
  refine ⟨four, ?_⟩
  rintro n ⟨D, hD⟩
  by_contra h
  have hc := hD.card_eq
  have lower := total_domination_lower D hD.isTotalDominating
  omega

/-- Complete negation of the universal inequality in the frozen declaration. -/
theorem counterexample : ¬∀ (α : Type) [Fintype α] [DecidableEq α] [Nontrivial α]
    (G : SimpleGraph α) [DecidableRel G.Adj] (_h : G.Connected)
    (_hn : 2 < Fintype.card α),
    G.totalDominationNumber ≤ havelHakimiZeroStep G + freqMinTriangles G := by
  intro h
  have bad := h (Fin 12) witness witness_connected (by decide)
  rw [domination_certificate, zero_step_certificate, frequency_certificate] at bad
  omega

/-- Exact frozen false-answer statement, without use of the admitted target. -/
theorem conjecture291 : False ↔
    ∀ (α : Type) [Fintype α] [DecidableEq α] [Nontrivial α]
      (G : SimpleGraph α) [DecidableRel G.Adj] (_h : G.Connected)
      (_hn : 2 < Fintype.card α),
      G.totalDominationNumber ≤ havelHakimiZeroStep G + freqMinTriangles G :=
  ⟨False.elim, fun h => counterexample h⟩


end ResearchWOWII291
