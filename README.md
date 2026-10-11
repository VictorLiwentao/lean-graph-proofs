# Lean graph proofs

Lean formalizations of known results from *Written on the Wall II*, by **Wentao Li**, with AI assistance. The original Lean statements and shared graph definitions are by **The Formal Conjectures Authors**. The mathematical authors are credited below and in each source note.

| Problem | Result | Lean proof | Explanation and sources |
| --- | --- | --- | --- |
| WOWII 101 | Hajnal independence-core inequality | [WOWII101.lean](LeanGraphProofs/WOWII101.lean) | [Proof](proofs/WOWII101/PROOF.md) · [Sources](proofs/WOWII101/SOURCE.md) |
| WOWII 20 | Induced bipartite subgraph bound | [WOWII20.lean](LeanGraphProofs/WOWII20.lean) | [Proof](proofs/WOWII20/PROOF.md) · [Sources](proofs/WOWII20/SOURCE.md) |
| WOWII 7 | Spanning-tree leaf bound | [WOWII7.lean](LeanGraphProofs/WOWII7.lean) | [Proof](proofs/WOWII7/PROOF.md) · [Sources](proofs/WOWII7/SOURCE.md) |

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
