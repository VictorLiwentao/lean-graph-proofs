# WOWII32 sources and provenance

Formalization and exposition: Wentao Li (2026), with OpenAI Codex assistance. The mathematical source is Ermelinda DeLaViña's *Written on the Wall II*. The original Lean statement and shared definitions are by The Formal Conjectures Authors, under Apache-2.0; their notices are retained.

The exact [DeepMind statement](https://github.com/google-deepmind/formal-conjectures/blob/1a339399f9d49d5f086e78851a372d38ded8c427/FormalConjectures/WrittenOnTheWallII/GraphConjecture32.lean) is unchanged from the research baseline `86daeae6fa80d23eb32bb610aa499ce88180c5a5`. Its full finite/nontrivial/connected domain and invariant definitions are preserved. The outcome is **Disproved**: the certificate proves the negation of the proposed universal inequality.

The counterexample P5 is recorded in the original WOWII collection (August 2005). PR #5729 corrected the distance average; its proof remains admitted. The September 21, 2026 Epoch review report records an exact Lean proof in `boundaries.lean`. The coordinator recovered that proof's source and successful command history from the linked public transcript. Our implementation was developed separately; no proof code from that transcript was copied. This is an independent formalization, with no first-formalization claim.

Sources checked October 12, 2026:

- [WOWII collection](https://cms.uhd.edu/faculty/delavinae/research/wowII/); the coordinator used the archived numbered list and glossary when the live site was unavailable.
- [Earlier public review](https://github.com/tadamcz/fc-review-results/blob/971290dd3e0e4dce063f98feaa8ecb9e51acd5ec/data/782312817c/files/WrittenOnTheWallII/GraphConjecture32.json).
- [Earlier execution transcript](https://epochai-public-eval-logs-manual.s3.amazonaws.com/eval-transcripts/autoformalization/fc-review-w301bafk8bbyekh9/index.html#/tasks/2026-09-21T13-06-55-00-00_fc-review_YcR28pxxd2Keg4QcdrSAdo.eval/samples/sample/WrittenOnTheWallII%2FGraphConjecture32/1/).
- [Statement correction, PR #5729](https://github.com/google-deepmind/formal-conjectures/pull/5729).

The immutable local research checkpoint is `68732e53fd1aec8896297b93cf93e723ebf8b7f7`. The independent review freshly rebuilt the candidate, checked the exact statement and referenced definitions with Comparator, inspected the transitive axiom closure, and replayed it in Lean's built-in kernel. The public module is a packaging port with the same mathematics. [Verification](../../verification/README.md) records its fresh builds and final comparison. No admitted source theorem, custom axiom or native-evaluation shortcut enters the result.

The live all-state DeepMind PR search on October 12 found no full proof PR for this exact target before this submission. Searches are bounded; this is not a claim of exhaustive absence. See [PROOF.md](PROOF.md) for the argument and exact theorem.
