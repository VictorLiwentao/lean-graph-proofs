/-
Copyright 2025 The Formal Conjectures Authors.
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
Authors: Wentao Li
-/
import LeanGraphProofs.Support.VertexDistance
import Mathlib.Combinatorics.SimpleGraph.Diam
import Mathlib.Tactic
import Mathlib.Combinatorics.SimpleGraph.Acyclic

/-!
# WOWII 34: kernel certification of a known counterexample

The 39-vertex tree is documented by Salvatore Mercuri (`smmercuri`) in
https://github.com/google-deepmind/formal-conjectures/pull/5733.
Original conjecture: E. DeLaViña, Written on the Wall II, Conjecture 34.
AI assistance: Codex GPT-6.1 Sol.
See proofs/WOWII34/PROOF.md and proofs/WOWII34/SOURCE.md for the argument and provenance.
-/
namespace WOWII34
open SimpleGraph

set_option maxRecDepth 100000
set_option maxHeartbeats 4000000

abbrev V := Fin 39

def edgeList : List (ℕ × ℕ) :=
  [(0, 1), (0, 2), (0, 3), (0, 4), (4, 5), (5, 6), (6, 7), (7, 8), (8, 9), (8, 10), (9, 11), (9, 12), (10, 13), (10, 14), (11, 15), (11, 16), (12, 17), (12, 18), (13, 19), (13, 20), (14, 21), (14, 22), (15, 23), (15, 24), (16, 25), (16, 26), (17, 27), (17, 28), (18, 29), (18, 30), (19, 31), (19, 32), (20, 33), (20, 34), (21, 35), (21, 36), (22, 37), (22, 38)]

def G : SimpleGraph V where
  Adj a b := (a.val, b.val) ∈ edgeList ∨ (b.val, a.val) ∈ edgeList
  symm.symm := by intro a b h; exact h.symm
  loopless.irrefl := by
    intro a
    have h : ∀ a : V, ¬ ((a.val, a.val) ∈ edgeList) := by decide
    simpa only [or_self] using h a

instance : DecidableRel G.Adj := fun _ _ => inferInstanceAs (Decidable (_ ∨ _))

/-- Claimed distances; correctness is proved from local certificates below. -/
def distanceRows : List (List ℕ) :=
  [
    [0, 1, 1, 1, 1, 2, 3, 4, 5, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [1, 0, 2, 2, 2, 3, 4, 5, 6, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
    [1, 2, 0, 2, 2, 3, 4, 5, 6, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
    [1, 2, 2, 0, 2, 3, 4, 5, 6, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
    [1, 2, 2, 2, 0, 1, 2, 3, 4, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8],
    [2, 3, 3, 3, 1, 0, 1, 2, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7],
    [3, 4, 4, 4, 2, 1, 0, 1, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6],
    [4, 5, 5, 5, 3, 2, 1, 0, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
    [5, 6, 6, 6, 4, 3, 2, 1, 0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    [6, 7, 7, 7, 5, 4, 3, 2, 1, 0, 2, 1, 1, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5],
    [6, 7, 7, 7, 5, 4, 3, 2, 1, 2, 0, 3, 3, 1, 1, 4, 4, 4, 4, 2, 2, 2, 2, 5, 5, 5, 5, 5, 5, 5, 5, 3, 3, 3, 3, 3, 3, 3, 3],
    [7, 8, 8, 8, 6, 5, 4, 3, 2, 1, 3, 0, 2, 4, 4, 1, 1, 3, 3, 5, 5, 5, 5, 2, 2, 2, 2, 4, 4, 4, 4, 6, 6, 6, 6, 6, 6, 6, 6],
    [7, 8, 8, 8, 6, 5, 4, 3, 2, 1, 3, 2, 0, 4, 4, 3, 3, 1, 1, 5, 5, 5, 5, 4, 4, 4, 4, 2, 2, 2, 2, 6, 6, 6, 6, 6, 6, 6, 6],
    [7, 8, 8, 8, 6, 5, 4, 3, 2, 3, 1, 4, 4, 0, 2, 5, 5, 5, 5, 1, 1, 3, 3, 6, 6, 6, 6, 6, 6, 6, 6, 2, 2, 2, 2, 4, 4, 4, 4],
    [7, 8, 8, 8, 6, 5, 4, 3, 2, 3, 1, 4, 4, 2, 0, 5, 5, 5, 5, 3, 3, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 4, 4, 4, 4, 2, 2, 2, 2],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 2, 4, 1, 3, 5, 5, 0, 2, 4, 4, 6, 6, 6, 6, 1, 1, 3, 3, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7, 7, 7],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 2, 4, 1, 3, 5, 5, 2, 0, 4, 4, 6, 6, 6, 6, 3, 3, 1, 1, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7, 7, 7],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 2, 4, 3, 1, 5, 5, 4, 4, 0, 2, 6, 6, 6, 6, 5, 5, 5, 5, 1, 1, 3, 3, 7, 7, 7, 7, 7, 7, 7, 7],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 2, 4, 3, 1, 5, 5, 4, 4, 2, 0, 6, 6, 6, 6, 5, 5, 5, 5, 3, 3, 1, 1, 7, 7, 7, 7, 7, 7, 7, 7],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 4, 2, 5, 5, 1, 3, 6, 6, 6, 6, 0, 2, 4, 4, 7, 7, 7, 7, 7, 7, 7, 7, 1, 1, 3, 3, 5, 5, 5, 5],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 4, 2, 5, 5, 1, 3, 6, 6, 6, 6, 2, 0, 4, 4, 7, 7, 7, 7, 7, 7, 7, 7, 3, 3, 1, 1, 5, 5, 5, 5],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 4, 2, 5, 5, 3, 1, 6, 6, 6, 6, 4, 4, 0, 2, 7, 7, 7, 7, 7, 7, 7, 7, 5, 5, 5, 5, 1, 1, 3, 3],
    [8, 9, 9, 9, 7, 6, 5, 4, 3, 4, 2, 5, 5, 3, 1, 6, 6, 6, 6, 4, 4, 2, 0, 7, 7, 7, 7, 7, 7, 7, 7, 5, 5, 5, 5, 3, 3, 1, 1],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 2, 4, 6, 6, 1, 3, 5, 5, 7, 7, 7, 7, 0, 2, 4, 4, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 2, 4, 6, 6, 1, 3, 5, 5, 7, 7, 7, 7, 2, 0, 4, 4, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 2, 4, 6, 6, 3, 1, 5, 5, 7, 7, 7, 7, 4, 4, 0, 2, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 2, 4, 6, 6, 3, 1, 5, 5, 7, 7, 7, 7, 4, 4, 2, 0, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 4, 2, 6, 6, 5, 5, 1, 3, 7, 7, 7, 7, 6, 6, 6, 6, 0, 2, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 4, 2, 6, 6, 5, 5, 1, 3, 7, 7, 7, 7, 6, 6, 6, 6, 2, 0, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 4, 2, 6, 6, 5, 5, 3, 1, 7, 7, 7, 7, 6, 6, 6, 6, 4, 4, 0, 2, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 3, 5, 4, 2, 6, 6, 5, 5, 3, 1, 7, 7, 7, 7, 6, 6, 6, 6, 4, 4, 2, 0, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 2, 4, 7, 7, 7, 7, 1, 3, 5, 5, 8, 8, 8, 8, 8, 8, 8, 8, 0, 2, 4, 4, 6, 6, 6, 6],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 2, 4, 7, 7, 7, 7, 1, 3, 5, 5, 8, 8, 8, 8, 8, 8, 8, 8, 2, 0, 4, 4, 6, 6, 6, 6],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 2, 4, 7, 7, 7, 7, 3, 1, 5, 5, 8, 8, 8, 8, 8, 8, 8, 8, 4, 4, 0, 2, 6, 6, 6, 6],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 2, 4, 7, 7, 7, 7, 3, 1, 5, 5, 8, 8, 8, 8, 8, 8, 8, 8, 4, 4, 2, 0, 6, 6, 6, 6],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 4, 2, 7, 7, 7, 7, 5, 5, 1, 3, 8, 8, 8, 8, 8, 8, 8, 8, 6, 6, 6, 6, 0, 2, 4, 4],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 4, 2, 7, 7, 7, 7, 5, 5, 1, 3, 8, 8, 8, 8, 8, 8, 8, 8, 6, 6, 6, 6, 2, 0, 4, 4],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 4, 2, 7, 7, 7, 7, 5, 5, 3, 1, 8, 8, 8, 8, 8, 8, 8, 8, 6, 6, 6, 6, 4, 4, 0, 2],
    [9, 10, 10, 10, 8, 7, 6, 5, 4, 5, 3, 6, 6, 4, 2, 7, 7, 7, 7, 5, 5, 3, 1, 8, 8, 8, 8, 8, 8, 8, 8, 6, 6, 6, 6, 4, 4, 2, 0]
  ]

def d (a b : V) : ℕ := (distanceRows.getD a.val []).getD b.val 0

/-- A neighbor on the route to each destination. -/
def nextRows : List (List ℕ) :=
  [
    [0, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
    [4, 4, 4, 4, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6],
    [5, 5, 5, 5, 5, 5, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7],
    [6, 6, 6, 6, 6, 6, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8],
    [7, 7, 7, 7, 7, 7, 7, 7, 8, 9, 10, 9, 9, 10, 10, 9, 9, 9, 9, 10, 10, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10],
    [8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 11, 12, 8, 8, 11, 11, 12, 12, 8, 8, 8, 8, 11, 11, 11, 11, 12, 12, 12, 12, 8, 8, 8, 8, 8, 8, 8, 8],
    [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 10, 8, 8, 13, 14, 8, 8, 8, 8, 13, 13, 14, 14, 8, 8, 8, 8, 8, 8, 8, 8, 13, 13, 13, 13, 14, 14, 14, 14],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 11, 9, 9, 9, 15, 16, 9, 9, 9, 9, 9, 9, 15, 15, 16, 16, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 12, 9, 9, 9, 9, 17, 18, 9, 9, 9, 9, 9, 9, 9, 9, 17, 17, 18, 18, 9, 9, 9, 9, 9, 9, 9, 9],
    [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 19, 20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 19, 19, 20, 20, 10, 10, 10, 10],
    [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 10, 10, 10, 10, 10, 10, 21, 22, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 21, 21, 22, 22],
    [11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 15, 11, 11, 11, 11, 11, 11, 11, 23, 24, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11],
    [11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 16, 11, 11, 11, 11, 11, 11, 11, 11, 25, 26, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11],
    [12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 17, 12, 12, 12, 12, 12, 12, 12, 12, 12, 27, 28, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12],
    [12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 18, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 29, 30, 12, 12, 12, 12, 12, 12, 12, 12],
    [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 19, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 31, 32, 13, 13, 13, 13, 13, 13],
    [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 20, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 33, 34, 13, 13, 13, 13],
    [14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 21, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 35, 36, 14, 14],
    [14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 22, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 37, 38],
    [15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 23, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15],
    [15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 24, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15],
    [16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 25, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16],
    [16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 26, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16],
    [17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 27, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17],
    [17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 28, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17],
    [18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 29, 18, 18, 18, 18, 18, 18, 18, 18, 18],
    [18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 30, 18, 18, 18, 18, 18, 18, 18, 18],
    [19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 31, 19, 19, 19, 19, 19, 19, 19],
    [19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 32, 19, 19, 19, 19, 19, 19],
    [20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 33, 20, 20, 20, 20, 20],
    [20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 34, 20, 20, 20, 20],
    [21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 35, 21, 21, 21],
    [21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 36, 21, 21],
    [22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 37, 22],
    [22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 38]
  ]

def nextVertex (a b : V) : V :=
  ⟨((nextRows.getD a.val []).getD b.val 0) % 39, Nat.mod_lt _ (by omega)⟩

lemma d_zero : ∀ a b : V, d a b = 0 ↔ a = b := by decide

lemma d_lipschitz : ∀ a b : V, G.Adj a b → ∀ t : V, d a t ≤ d b t + 1 := by
  decide

lemma d_step : ∀ a t : V, d a t ≠ 0 →
    G.Adj a (nextVertex a t) ∧ d (nextVertex a t) t + 1 = d a t := by
  decide

lemma exists_walk (a t : V) : ∃ p : G.Walk a t, p.length = d a t := by
  generalize hn : d a t = n
  induction n using Nat.strong_induction_on generalizing a with
  | h n ih =>
    by_cases hz : d a t = 0
    · have hat := (d_zero a t).mp hz
      subst a
      exact ⟨.nil, by simp_all⟩
    · obtain ⟨ha, hd⟩ := d_step a t hz
      obtain ⟨p, hp⟩ := ih (d (nextVertex a t) t) (by omega) (nextVertex a t) rfl
      exact ⟨.cons ha p, by simp only [Walk.length_cons]; omega⟩

lemma connected : G.Connected := by
  constructor
  intro a t
  obtain ⟨p, _⟩ := exists_walk a t
  exact p.reachable

lemma d_le_length {a t : V} (p : G.Walk a t) : d a t ≤ p.length := by
  induction p with
  | @nil u => have := (d_zero u u).mpr rfl; simpa using this.le
  | @cons a b t hab p ih =>
    have := d_lipschitz a b hab t
    simp only [Walk.length_cons]
    omega

lemma dist_eq (a t : V) : G.dist a t = d a t := by
  apply le_antisymm
  · obtain ⟨p, hp⟩ := exists_walk a t
    exact hp ▸ dist_le p
  · obtain ⟨p, hp⟩ := connected.exists_walk_length_eq_dist a t
    exact hp ▸ d_le_length p

lemma distance_bound : ∀ a b : V, d a b ≤ 10 := by decide

lemma edge_count : G.edgeFinset.card = 38 := by decide

lemma tree : G.IsTree := by
  apply isTree_iff_connected_and_card.mpr
  refine ⟨connected, ?_⟩
  rw [Nat.card_eq_fintype_card, ← edgeFinset_card, edge_count]
  simp [Nat.card_eq_fintype_card]

lemma path_length_eq_dist {a b : V} {p : G.Walk a b} (hp : p.IsPath) :
    p.length = G.dist a b := by
  obtain ⟨q, hq, hlen⟩ := connected.exists_path_of_dist a b
  have heq := (tree.isAcyclic.subsingleton_path a b).elim ⟨p, hp⟩ ⟨q, hq⟩
  have : p = q := congrArg Subtype.val heq
  simpa [this] using hlen

lemma induced_length_bound (l : List V) (h : G.isInducedPath l) : l.length ≤ 11 := by
  by_cases hn : l = []
  · simp [hn]
  · have hc : l.IsChain G.Adj := by
      rw [List.isChain_iff_getElem]
      intro i hi
      exact (h.2 ⟨i, by omega⟩ ⟨i + 1, hi⟩).mpr (Or.inl rfl)
    let w := Walk.ofSupport l hn hc
    have hp : w.IsPath := by
      apply Walk.IsPath.mk'
      simpa [w] using h.1
    have hl := path_length_eq_dist hp
    rw [dist_eq] at hl
    have hb := distance_bound (l.head hn) (l.getLast hn)
    have hw : w.length = l.length - 1 := Walk.length_ofSupport hn hc
    have hpos : 0 < l.length := List.length_pos_iff.mpr hn
    omega

def longestPath : List V := [1, 0, 4, 5, 6, 7, 8, 9, 11, 15, 23]

lemma longest_induced : G.isInducedPath longestPath := by
  unfold SimpleGraph.isInducedPath
  decide

/-- Convert the representation used by the frozen `path` definition to the `WithBot` API. -/
lemma getD_eq_unbotD (x : WithBot ℕ) : x.getD 0 = x.unbotD 0 := by
  cases x <;> rfl

lemma path_le : G.path ≤ 11 := by
  classical
  let paths := Finset.univ.filter (fun s : Finset V =>
    ∃ l : List V, l.toFinset = s ∧ G.isInducedPath l)
  let sizes := paths.image Finset.card
  have hb : ∀ n ∈ sizes, n ≤ 11 := by
    intro n hn
    obtain ⟨s, hs, rfl⟩ := Finset.mem_image.mp hn
    obtain ⟨l, rfl, hl⟩ := (Finset.mem_filter.mp hs).2
    exact (List.toFinset_card_le l).trans (induced_length_bound l hl)
  change sizes.max.getD 0 ≤ 11
  rw [getD_eq_unbotD, WithBot.unbotD_le_iff (by intro _; omega)]
  exact Finset.max_le (fun n hn => by exact_mod_cast hb n hn)

lemma path_ge : 11 ≤ G.path := by
  classical
  let paths := Finset.univ.filter (fun s : Finset V =>
    ∃ l : List V, l.toFinset = s ∧ G.isInducedPath l)
  let sizes := paths.image Finset.card
  have hl : longestPath.toFinset ∈ paths :=
    Finset.mem_filter.mpr ⟨Finset.mem_univ _, longestPath, rfl, longest_induced⟩
  have hc : longestPath.toFinset.card = 11 := by decide
  have hs : 11 ∈ sizes := Finset.mem_image.mpr ⟨_, hl, hc⟩
  obtain ⟨n, hn⟩ := Finset.max_of_mem hs
  change sizes.max.getD 0 ≥ 11
  rw [hn]
  exact Finset.le_max_of_eq hs hn

lemma path_eq : G.path = 11 := le_antisymm path_le path_ge

/-- Eccentricities computed from the certified distance table. -/
def e (a : V) : ℕ := Finset.univ.sup (d a)

lemma eccent_eq (a : V) : G.eccent a = (e a : ℕ∞) := by
  apply le_antisymm
  · rw [eccent_le_iff]
    intro b
    rw [← (connected a b).coe_dist_eq_edist, dist_eq]
    exact_mod_cast Finset.le_sup (f := d a) (Finset.mem_univ b)
  · obtain ⟨b, _, hb⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (d a)
    have he : e a = d a b := hb
    rw [he, ← dist_eq, (connected a b).coe_dist_eq_edist]
    exact edist_le_eccent

lemma e_min : ∀ a : V, 5 ≤ e a := by decide
lemma e_center : ∀ a : V, e a = 5 ↔ a = 7 := by decide

lemma radius_eq : G.radius = 5 := by
  apply le_antisymm
  · have he : e 7 = 5 := (e_center 7).mpr rfl
    have hr := G.radius_le_eccent (u := (7 : V))
    simpa [eccent_eq, he] using hr
  · unfold SimpleGraph.radius
    apply le_iInf
    intro a
    rw [eccent_eq]
    exact_mod_cast e_min a

lemma center_eq : G.center = {7} := by
  ext a
  change G.eccent a = G.radius ↔ a = 7
  rw [eccent_eq, radius_eq]
  exact_mod_cast e_center a

lemma max_degree : G.maxDegree = 4 := by decide
lemma degree_max_iff : ∀ a : V, G.degree a = 4 ↔ a = 0 := by decide

lemma maximum_eq : {a : V | G.degree a = G.maxDegree} = {0} := by
  ext a
  change G.degree a = G.maxDegree ↔ a = 0
  rw [max_degree]
  exact degree_max_iff a

noncomputable def avg (S : Set V) : ℝ :=
  open scoped Classical in
  let pairs := (S.toFinset ×ˢ Finset.univ).filter (fun p => G.dist p.1 p.2 ≠ 0)
  (∑ p ∈ pairs, (G.dist p.1 p.2 : ℝ)) / pairs.card

def pairSet (a : V) : Finset (V × V) :=
  ({a} ×ˢ Finset.univ).filter (fun p => d p.1 p.2 ≠ 0)

lemma avg_singleton (a : V) :
    avg {a} = (∑ p ∈ pairSet a, (d p.1 p.2 : ℝ)) / (pairSet a).card := by
  classical
  simp only [avg, Set.toFinset_singleton, dist_eq, pairSet]

lemma center_pair_count : (pairSet 7).card = 38 := by decide
lemma maximum_pair_count : (pairSet 0).card = 38 := by decide
lemma center_pair_sum : ∑ p ∈ pairSet 7, d p.1 p.2 = 154 := by decide
lemma maximum_pair_sum : ∑ p ∈ pairSet 0, d p.1 p.2 = 266 := by decide

lemma center_avg : avg G.center = 154 / 38 := by
  rw [center_eq, avg_singleton, center_pair_count]
  have hs : (∑ p ∈ pairSet 7, (d p.1 p.2 : ℝ)) = 154 := by
    exact_mod_cast center_pair_sum
  rw [hs]
  norm_num

lemma maximum_avg : avg {a : V | G.degree a = G.maxDegree} = 266 / 38 := by
  rw [maximum_eq, avg_singleton, maximum_pair_count]
  have hs : (∑ p ∈ pairSet 0, (d p.1 p.2 : ℝ)) = 266 := by
    exact_mod_cast maximum_pair_sum
  rw [hs]
  norm_num

lemma bound_ceiling :
    Int.ceil (avg G.center + avg {a : V | G.degree a = G.maxDegree}) = 12 := by
  rw [center_avg, maximum_avg, Int.ceil_eq_iff]
  constructor <;> norm_num

/-- The documented 39-vertex tree refutes the corrected WOWII 34 inequality. -/
theorem counterexample :
    ¬ Int.ceil (avg G.center + avg {a : V | G.degree a = G.maxDegree}) ≤ (G.path : ℤ) := by
  rw [bound_ceiling, path_eq]
  norm_num

/-- Complete negative answer to the exact frozen universal statement. -/
theorem conjecture34 :
  False ↔
    ∀ (α : Type) [Fintype α] [DecidableEq α] [Nontrivial α]
      (G : SimpleGraph α) [DecidableRel G.Adj] (_h : G.Connected),
      let C : Set α := center G
      let M : Set α := {v | G.degree v = G.maxDegree}
      let distAvg (S : Set α) : ℝ :=
        open scoped Classical in
        let pairs := (S.toFinset ×ˢ Finset.univ).filter (fun p => G.dist p.1 p.2 ≠ 0)
        (∑ p ∈ pairs, (G.dist p.1 p.2 : ℝ)) / pairs.card
      Int.ceil (distAvg C + distAvg M) ≤ (path G : ℤ) := by
  constructor
  · intro h; exact h.elim
  · intro h
    exact counterexample (h V G connected)


end WOWII34
