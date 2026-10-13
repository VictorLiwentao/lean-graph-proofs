# WOWII32: sources and attribution

The five-vertex path disproves WOWII Conjecture 32: the proposed lower bound is `16/3`, while the largest induced path has five vertices.

The five-vertex path counterexample is recorded in Ermelinda DeLaViña's *Written on the Wall II* (August 2005). The formalization by **Wentao Li** uses the corrected distance average from [PR #5729](https://github.com/google-deepmind/formal-conjectures/pull/5729). An earlier exact Lean proof appears in `boundaries.lean` in the September 21, 2026 **Epoch review**, archived in **tadamcz/fc-review-results** and the public execution transcript linked below.

**Lean formalization and write-up:** Wentao Li (2026), with OpenAI Codex assistance.
**Mathematical collection:** Ermelinda DeLaViña, *Written on the Wall II*.
**Original Lean statement and shared definitions:** The Formal Conjectures Authors, Apache-2.0. Their copyright notices are retained.

The certificate proves the negation of the full [DeepMind statement](https://github.com/google-deepmind/formal-conjectures/blob/1a339399f9d49d5f086e78851a372d38ded8c427/FormalConjectures/WrittenOnTheWallII/GraphConjecture32.lean), preserving its finite, nontrivial and connected graph hypotheses and original invariant definitions. This statement is unchanged from research baseline `86daeae6fa80d23eb32bb610aa499ce88180c5a5`.

Sources checked October 12, 2026:

- [WOWII collection](https://cms.uhd.edu/faculty/delavinae/research/wowII/); source comparison used the archived numbered list and glossary.
- [Earlier public review](https://github.com/tadamcz/fc-review-results/blob/971290dd3e0e4dce063f98feaa8ecb9e51acd5ec/data/782312817c/files/WrittenOnTheWallII/GraphConjecture32.json).
- [Earlier execution transcript](https://epochai-public-eval-logs-manual.s3.amazonaws.com/eval-transcripts/autoformalization/fc-review-w301bafk8bbyekh9/index.html#/tasks/2026-09-21T13-06-55-00-00_fc-review_YcR28pxxd2Keg4QcdrSAdo.eval/samples/sample/WrittenOnTheWallII%2FGraphConjecture32/1/).
- [Statement correction, PR #5729](https://github.com/google-deepmind/formal-conjectures/pull/5729).

Research checkpoint: `68732e53fd1aec8896297b93cf93e723ebf8b7f7`. The [verification report](../../verification/README.md) records fresh compilation, exact statement and dependent-definition comparison with Comparator, and Lean kernel replay. The theorem uses only `propext`, `Classical.choice`, and `Quot.sound`.

See [PROOF.md](PROOF.md) for the argument and exact theorem.
