# WOWII34: sources and attribution

A 39-vertex tree disproves WOWII Conjecture 34: the proposed lower bound is `12`, while the largest induced path has eleven vertices.

**Salvatore Mercuri (`smmercuri`)** documented the 39-vertex tree and its invariant values in [PR #5733](https://github.com/google-deepmind/formal-conjectures/pull/5733). The formalization by **Wentao Li** certifies its distance table, connectedness, tree structure, induced-path bound and distance averages. The September 21, 2026 **Epoch review**, archived in **tadamcz/fc-review-results**, contains earlier witness and boundary checks.

**Lean formalization and write-up:** Wentao Li (2026), with OpenAI Codex assistance.
**Mathematical collection:** Ermelinda DeLaViña, *Written on the Wall II*.
**Original Lean statement and shared definitions:** The Formal Conjectures Authors, Apache-2.0. Their copyright notices are retained.

The certificate proves the negation of the full [DeepMind statement](https://github.com/google-deepmind/formal-conjectures/blob/1a339399f9d49d5f086e78851a372d38ded8c427/FormalConjectures/WrittenOnTheWallII/GraphConjecture34.lean), preserving its finite, nontrivial and connected graph hypotheses and original invariant definitions. This statement is unchanged from research baseline `86daeae6fa80d23eb32bb610aa499ce88180c5a5`.

Sources checked October 12, 2026:

- [WOWII collection](https://cms.uhd.edu/faculty/delavinae/research/wowII/); source comparison used the archived numbered list and glossary.
- [Earlier public review](https://github.com/tadamcz/fc-review-results/blob/971290dd3e0e4dce063f98feaa8ecb9e51acd5ec/data/782312817c/files/WrittenOnTheWallII/GraphConjecture34.json).
- [Earlier execution transcript](https://epochai-public-eval-logs-manual.s3.amazonaws.com/eval-transcripts/autoformalization/fc-review-w301bafk8bbyekh9/index.html#/tasks/2026-09-21T13-06-55-00-00_fc-review_YcR28pxxd2Keg4QcdrSAdo.eval/samples/sample/WrittenOnTheWallII%2FGraphConjecture34/1/).
- [Counterexample and correction, PR #5733](https://github.com/google-deepmind/formal-conjectures/pull/5733).

Research checkpoint: `54012e62dca52219518a84704642ef8899acf24e`. The [verification report](../../verification/README.md) records fresh compilation, exact statement and dependent-definition comparison with Comparator, and Lean kernel replay. The theorem uses only `propext`, `Classical.choice`, and `Quot.sound`.

See [PROOF.md](PROOF.md) for the argument and exact theorem.
