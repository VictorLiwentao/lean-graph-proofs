# Lean graph proofs

Lean formalizations of known results from *Written on the Wall II*, by **Wentao Li**, with AI assistance. The original Lean statements and shared graph definitions are by **The Formal Conjectures Authors**. The mathematical authors are credited below and in each source note.

| Problem | Result | Lean proof | Explanation and sources | DeepMind PR |
| --- | --- | --- | --- | --- |
| WOWII 101 | Hajnal independence-core inequality | [WOWII101.lean](LeanGraphProofs/WOWII101.lean) | [Proof](proofs/WOWII101/PROOF.md) · [Sources](proofs/WOWII101/SOURCE.md) | [#7115](https://github.com/google-deepmind/formal-conjectures/pull/7115) |
| WOWII 20 | Induced bipartite subgraph bound | [WOWII20.lean](LeanGraphProofs/WOWII20.lean) | [Proof](proofs/WOWII20/PROOF.md) · [Sources](proofs/WOWII20/SOURCE.md) | [#7117](https://github.com/google-deepmind/formal-conjectures/pull/7117) |
| WOWII 7 | Spanning-tree leaf bound | [WOWII7.lean](LeanGraphProofs/WOWII7.lean) | [Proof](proofs/WOWII7/PROOF.md) · [Sources](proofs/WOWII7/SOURCE.md) | [#7119](https://github.com/google-deepmind/formal-conjectures/pull/7119) |
| WOWII 32 | Five-vertex path counterexample | [WOWII32.lean](LeanGraphProofs/WOWII32.lean) | [Proof](proofs/WOWII32/PROOF.md) · [Sources](proofs/WOWII32/SOURCE.md) | [#7246](https://github.com/google-deepmind/formal-conjectures/pull/7246) |
| WOWII 34 | 39-vertex tree counterexample | [WOWII34.lean](LeanGraphProofs/WOWII34.lean) | [Proof](proofs/WOWII34/PROOF.md) · [Sources](proofs/WOWII34/SOURCE.md) | [#7247](https://github.com/google-deepmind/formal-conjectures/pull/7247) |
| WOWII 291 | Twelve-vertex counterexample | [WOWII291.lean](LeanGraphProofs/WOWII291.lean) | [Proof](proofs/WOWII291/PROOF.md) · [Sources](proofs/WOWII291/SOURCE.md) | [#7248](https://github.com/google-deepmind/formal-conjectures/pull/7248) |

Each problem has one canonical Lean file and one proof/source pair. Shared definitions live in `LeanGraphProofs/Support/`. [Verification](verification/README.md) records fresh compilation, Comparator statement/definition comparison and kernel replay.

## Build

Install [elan](https://github.com/leanprover/elan), then run:

```sh
lake exe cache get
lake --wfail build LeanGraphProofs
```

Lean and Mathlib are pinned to v4.34.0-rc2. The recorded macOS audit used the direct pinned Lean compiler; see the verification instructions for that fallback.

## Contributing

Keep one canonical location per file; no compatibility copies or redirects. Preserve the exact statements and attribution. Keep proof claims, prior mathematical results and verification evidence separate. Rebuild changed modules, inspect theorem axioms, and compare any submitted proof with the original statement.

Licensed under Apache-2.0. See [LICENSE](LICENSE) and [PROVENANCE.md](PROVENANCE.md).
