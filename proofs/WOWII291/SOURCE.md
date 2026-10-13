# WOWII291: sources and attribution

A twelve-vertex graph disproves WOWII Conjecture 291: its total domination number is `4`, its first Havel–Hakimi zero step is `2`, and its minimum-triangle frequency is `1`, giving `4 > 2 + 1`.

The WOWII source credits **Zyad Tamimi** with a twelve-vertex refutation dated July 23, 2026, recorded in [PR #5395](https://github.com/google-deepmind/formal-conjectures/pull/5395). The formalization by **Wentao Li** certifies the `m = 6` member of the book-graph family documented by **`vulnix0x4`** in [issue #4562](https://github.com/google-deepmind/formal-conjectures/issues/4562). The September 21, 2026 **Epoch review**, archived in **tadamcz/fc-review-results**, checks the definitions and boundary cases.

**Lean formalization and write-up:** Wentao Li (2026), with OpenAI Codex assistance.
**Mathematical collection:** Ermelinda DeLaViña, *Written on the Wall II*.
**Original Lean statement and shared definitions:** The Formal Conjectures Authors, Apache-2.0. Their copyright notices are retained.

The certificate proves the negation of the full [DeepMind statement](https://github.com/google-deepmind/formal-conjectures/blob/1a339399f9d49d5f086e78851a372d38ded8c427/FormalConjectures/WrittenOnTheWallII/GraphConjecture291.lean), preserving its finite and connected graph hypotheses, the `n > 2` condition, and the original invariant definitions. This statement is unchanged from research baseline `86daeae6fa80d23eb32bb610aa499ce88180c5a5`.

Sources checked October 12, 2026:

- [WOWII collection](https://cms.uhd.edu/faculty/delavinae/research/wowII/); source comparison used the archived numbered list and glossary.
- [Earlier public review](https://github.com/tadamcz/fc-review-results/blob/971290dd3e0e4dce063f98feaa8ecb9e51acd5ec/data/782312817c/files/WrittenOnTheWallII/GraphConjecture291.json).
- [Earlier execution transcript](https://epochai-public-eval-logs-manual.s3.amazonaws.com/eval-transcripts/autoformalization/fc-review-w301bafk8bbyekh9/index.html#/tasks/2026-09-21T13-06-55-00-00_fc-review_YcR28pxxd2Keg4QcdrSAdo.eval/samples/sample/WrittenOnTheWallII%2FGraphConjecture291/1/).
- [Witness family, issue #4562](https://github.com/google-deepmind/formal-conjectures/issues/4562).
- [Known refutation, PR #5395](https://github.com/google-deepmind/formal-conjectures/pull/5395).

Research checkpoint: `c6858edb971abef41b0537e6d1a4b00711fb5cbd`. The [verification report](../../verification/README.md) records fresh compilation, exact statement and dependent-definition comparison with Comparator, and Lean kernel replay. The theorem uses only `propext`, `Classical.choice`, and `Quot.sound`.

See [PROOF.md](PROOF.md) for the argument and exact theorem.
