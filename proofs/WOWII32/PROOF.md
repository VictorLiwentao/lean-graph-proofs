# WOWII 32: the five-vertex path

The formalization by **Wentao Li**, with OpenAI Codex assistance, certifies the five-vertex path counterexample recorded in the WOWII collection in August 2005. An earlier exact Lean proof appears in the September 21, 2026 **Epoch review**, archived in **tadamcz/fc-review-results**; see [SOURCE.md](SOURCE.md).

Let G be the path 0–1–2–3–4. Its minimum-degree vertices are A={0,4}; the average over ordered pairs of distinct vertices of A is 4. The maximum-degree vertices are M={1,2,3}, with eccentricities 3,2,3 and average 8/3. The conjectured lower bound is therefore 4+(1/2)(8/3)=16/3. Every induced path has at most five vertices, so this exceeds path(G).

The Lean proof certifies the distance matrix through the proved computable-distance API and derives the eccentricities and degree sets. A general cardinality bound controls every induced path. Specializing the entire proposed universal inequality to this connected, finite, nontrivial graph yields a contradiction.

Canonical module: `LeanGraphProofs.WOWII32`. Main theorem: `WOWII32.conjecture32`. The theorem proves `False ↔` the exact original universal bound, using the corrected ordered-pair distance average. Its axioms are `propext`, `Classical.choice`, and `Quot.sound`. The public package uses Lean/Mathlib v4.34.0-rc2; exact correspondence is also checked on DeepMind's pinned Lean 4.33.1. See [verification](../../verification/README.md).
