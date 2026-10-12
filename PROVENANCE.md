# Provenance

The proof developments and accompanying write-ups are by Wentao Li (2026), with AI assistance. They formalize existing mathematics, credited in the per-problem source notes.

The original statement definitions and these support files come from [The Formal Conjectures Authors](https://github.com/google-deepmind/formal-conjectures/tree/4c40439d9be65b242e9196fb7848be02a9a4481d), under Apache-2.0:

- `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Independence.lean`
- `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Induced.lean`
- `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/SpanningTree.lean`
- The `indepNumDeleteVertex` and `alphaCore` definitions from `GraphConjecture101.lean`.

Their copyright notices are retained. Changes are import/module packaging and deprecated tactic-lemma spellings for Lean/Mathlib v4.34.0-rc2. Definition bodies and target types are preserved. The original research commit for each proof is linked in its `SOURCE.md`.

Mathlib and its dependencies retain their respective upstream licenses.

## WOWII 32, 34 and 291

Wentao Li developed the three counterexample certificates with OpenAI Codex assistance. These certify known mathematics. WOWII32 also has an earlier complete public Lean proof in the September 21 Epoch review transcript. No code from that transcript was copied. WOWII34 credits Salvatore Mercuri's tree from PR #5733. WOWII291 preserves Tamimi's refutation credit and separately credits the actual witness family to `vulnix0x4` (issue #4562).

The added support modules `Connectivity`, `VertexDistance`, `Degrees`, `Domination` and `Residue` come from Formal Conjectures commit `86daeae6fa80d23eb32bb610aa499ce88180c5a5`, under Apache-2.0. Connectivity and VertexDistance use adapted import/module packaging. Degrees, Domination and Residue are byte-identical upstream copies, preserving module visibility and reducibility metadata. Exact referenced definitions are independently compared with the original. The five target-local definitions in WOWII291 also retain their original values and copyright.

Per-target source notes link the mathematical sources, earlier formal checks, and verification scope. Existing release links and historical verification remain preserved.
