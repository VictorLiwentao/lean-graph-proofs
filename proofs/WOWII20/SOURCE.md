# WOWII20: sources and attribution

**Mathematics:** Noga Alon, Jeff Kahn and Paul D. Seymour, [Large Induced Degenerate Subgraphs](https://doi.org/10.1007/BF01788542), Graphs and Combinatorics 3 (1987), 203–211, Theorem 1.3 and Corollary 1.4. The formal proof specializes their weighted induction to induced bipartite sets.

**Lean proof and write-up:** Wentao Li, 2026, with AI assistance.
**Original Lean statement and shared graph definitions:** The Formal Conjectures Authors, Apache-2.0.

- [Current statement used for comparison](https://github.com/google-deepmind/formal-conjectures/blob/4c40439d9be65b242e9196fb7848be02a9a4481d/FormalConjectures/WrittenOnTheWallII/GraphConjecture20.lean).
- [Original research proof](https://github.com/VictorLiwentao/formal-conjectures/blob/dadf30cc901feb22fce0ba0bd200c5453266ac7a/research/batches/b01/workers/cursor-07-r04/targets/WOWII20/WOWII20.lean); SHA-256 `598c0a6231dbf61e68ded32dc047193c2149554d1b222caf28397cb1a719365c`.
- [Canonical published Lean proof](../../LeanGraphProofs/WOWII20.lean), declaration `WOWII20.conjecture20`.
- [Readable proof](PROOF.md) and [verification procedure](../../verification/README.md).

This package is a Lean formalization of known mathematics. The theorem retains the original finite-type, nontriviality and connectedness hypotheses. The current DeepMind target is compared to a wrapper applying this proof, including its dependent definitions.

The local support modules preserve the original graph definitions. Packaging changes remove repository-specific module/attribute metadata and use Mathlib v4.34.0-rc2; the deprecated tactic lemmas `dif_pos`, `if_pos`, and `if_neg` are renamed to `dite_eq_left`, `ite_eq_left`, and `ite_eq_right`. No target definition or mathematical hypothesis is changed.
