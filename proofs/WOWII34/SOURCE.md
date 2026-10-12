# WOWII34 sources and provenance

Formalization and exposition: Wentao Li (2026), with OpenAI Codex assistance. The mathematical source is Ermelinda DeLaViña's *Written on the Wall II*. The original Lean statement and shared definitions are by The Formal Conjectures Authors, under Apache-2.0; their notices are retained.

The exact [DeepMind statement](https://github.com/google-deepmind/formal-conjectures/blob/1a339399f9d49d5f086e78851a372d38ded8c427/FormalConjectures/WrittenOnTheWallII/GraphConjecture34.lean) is unchanged from the research baseline `86daeae6fa80d23eb32bb610aa499ce88180c5a5`. Its full finite/nontrivial/connected domain and invariant definitions are preserved. The outcome is **Disproved**: the certificate proves the negation of the proposed universal inequality.

Salvatore Mercuri (`smmercuri`) documented the 39-vertex tree and invariant values in PR #5733. The September 21, 2026 public review contains earlier native witness and boundary checks; the inspected command history did not yield a complete exact proof of the universal negation. This is a formalization of a known counterexample, not a new mathematical disproof or an absolute priority claim.

Sources checked October 12, 2026:

- [WOWII collection](https://cms.uhd.edu/faculty/delavinae/research/wowII/); the coordinator used the archived numbered list and glossary when the live site was unavailable.
- [Earlier public review](https://github.com/tadamcz/fc-review-results/blob/971290dd3e0e4dce063f98feaa8ecb9e51acd5ec/data/782312817c/files/WrittenOnTheWallII/GraphConjecture34.json).
- [Earlier execution transcript](https://epochai-public-eval-logs-manual.s3.amazonaws.com/eval-transcripts/autoformalization/fc-review-w301bafk8bbyekh9/index.html#/tasks/2026-09-21T13-06-55-00-00_fc-review_YcR28pxxd2Keg4QcdrSAdo.eval/samples/sample/WrittenOnTheWallII%2FGraphConjecture34/1/).
- [Counterexample and correction, PR #5733](https://github.com/google-deepmind/formal-conjectures/pull/5733).

The immutable local research checkpoint is `54012e62dca52219518a84704642ef8899acf24e`. The independent review freshly rebuilt the candidate, checked the exact statement and referenced definitions with Comparator, inspected the transitive axiom closure, and replayed it in Lean's built-in kernel. The public module is a packaging port with the same mathematics. [Verification](../../verification/README.md) records its fresh builds and final comparison. No admitted source theorem, custom axiom or native-evaluation shortcut enters the result.

The live all-state DeepMind PR search on October 12 found no full proof PR for this exact target before this submission. Searches are bounded; this is not a claim of exhaustive absence. See [PROOF.md](PROOF.md) for the argument and exact theorem.
