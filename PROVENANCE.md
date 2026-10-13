# Provenance

The Lean formalizations and accompanying write-ups are by **Wentao Li** (2026), with AI assistance. The mathematical sources and prior formalizations are credited in each problem’s source notes.

The original statement definitions and these support files come from [The Formal Conjectures Authors](https://github.com/google-deepmind/formal-conjectures/tree/4c40439d9be65b242e9196fb7848be02a9a4481d), under Apache-2.0:

- `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Independence.lean`
- `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Induced.lean`
- `FormalConjecturesForMathlib/Combinatorics/SimpleGraph/SpanningTree.lean`
- The `indepNumDeleteVertex` and `alphaCore` definitions from `GraphConjecture101.lean`.

Their copyright notices are retained. Changes are import/module packaging and deprecated tactic-lemma spellings for Lean/Mathlib v4.34.0-rc2. Definition bodies and target types are preserved. The original research commit for each proof is linked in its `SOURCE.md`.

Mathlib and its dependencies retain their respective upstream licenses.

## WOWII 32, 34 and 291

The three counterexample certificates are formalized by **Wentao Li**, with OpenAI Codex assistance.

- **WOWII 32:** The five-vertex path appears in the WOWII collection. An earlier Lean proof appears in the September 21, 2026 **Epoch review**, archived in **tadamcz/fc-review-results**. See [sources](proofs/WOWII32/SOURCE.md).
- **WOWII 34:** **Salvatore Mercuri (`smmercuri`)** documented the 39-vertex tree in [PR #5733](https://github.com/google-deepmind/formal-conjectures/pull/5733). See [sources](proofs/WOWII34/SOURCE.md).
- **WOWII 291:** The WOWII source credits **Zyad Tamimi** with the refutation. This certificate uses the `m = 6` member of the book-graph family documented by **`vulnix0x4`** in [issue #4562](https://github.com/google-deepmind/formal-conjectures/issues/4562). See [sources](proofs/WOWII291/SOURCE.md).

The added support modules `Connectivity`, `VertexDistance`, `Degrees`, `Domination` and `Residue` come from Formal Conjectures commit `86daeae6fa80d23eb32bb610aa499ce88180c5a5`, under Apache-2.0. Connectivity and VertexDistance use adapted import/module packaging. Degrees, Domination and Residue are byte-identical upstream copies, preserving module visibility and reducibility metadata. Exact referenced definitions are independently compared with the original. The five target-local definitions in WOWII291 also retain their original values and copyright.

Per-target source notes link the mathematical sources, earlier formal checks, and verification scope. Existing release links and historical verification remain preserved.
