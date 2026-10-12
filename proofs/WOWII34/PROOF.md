# WOWII 34: the 39-vertex tree

Formalization: Wentao Li, with OpenAI Codex assistance. Salvatore Mercuri (`smmercuri`) documented this counterexample in [DeepMind PR #5733](https://github.com/google-deepmind/formal-conjectures/pull/5733). This work certifies that known construction.

Take a vertex with three pendant leaves. Join it by a five-edge path to the root of a perfect binary tree of depth four. The resulting tree has 39 vertices and diameter 10. Its center and maximum-degree sets are singletons; their distance sums are 154 and 266. Each average divides by 38 because zero distances are excluded. The proposed lower bound is therefore ceil((154+266)/38)=12, whereas the largest induced path has 11 vertices.

The literal distance table is checked, not assumed. Kernel reduction proves that distance zero characterizes equality, that each edge changes the proposed distance by at most one, and that a next-vertex function decreases every positive distance by one. Induction constructs shortest walks and establishes the matching lower bound for arbitrary walks. This proves the table equals the graph metric and proves connectedness.

The graph has 38 edges. Connectedness and Mathlib's finite tree criterion establish acyclicity. In a tree every simple path is the unique shortest path between its endpoints; the certified diameter bounds its length by ten edges. The proof translates the original list-based induced-path predicate into a walk, so this bound controls every candidate in `SimpleGraph.path`. An explicit eleven-vertex induced path gives equality. The certified averages then refute the full original universal statement.

Canonical module: `LeanGraphProofs.WOWII34`. Main theorem: `WOWII34.conjecture34`. Its axioms are `propext`, `Classical.choice`, and `Quot.sound`. The public package uses Lean/Mathlib v4.34.0-rc2; exact correspondence is also checked on DeepMind's pinned Lean 4.33.1. See [verification](../../verification/README.md).
