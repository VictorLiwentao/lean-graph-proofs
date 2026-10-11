# WOWII101: sources and attribution

**Mathematics:** András Hajnal (1965); independent-set form in Vadim E. Levit and Eugen Mandrescu, [A Set and Collection Lemma](https://arxiv.org/abs/1101.4564), Corollaries 2.3–2.4.

**Lean proof and write-up:** Wentao Li, 2026, with AI assistance.
**Original Lean statement and shared graph definitions:** The Formal Conjectures Authors, Apache-2.0.

- [Current statement used for comparison](https://github.com/google-deepmind/formal-conjectures/blob/4c40439d9be65b242e9196fb7848be02a9a4481d/FormalConjectures/WrittenOnTheWallII/GraphConjecture101.lean).
- [Original research proof](https://github.com/VictorLiwentao/formal-conjectures/blob/b42564b6f4e04abf0256355f53000056e2c2c924/research/batches/b01/workers/cursor-07-r02/targets/WOWII101/WOWII101.lean); SHA-256 `5018f7ba7f2ec8b63d4334b606d8936db097e635f9c959c3d2877ae9dee8e34a`.
- [Canonical published Lean proof](../../LeanGraphProofs/WOWII101.lean), declaration `WOWII101.conjecture101`.
- [Readable proof](PROOF.md) and [verification procedure](../../verification/README.md).

This package is a Lean formalization of known mathematics. The theorem retains the original finite-type, nontriviality and connectedness hypotheses. The current DeepMind target is compared to a wrapper applying this proof, including its dependent definitions.

The local support modules preserve the original graph definitions. Packaging changes remove repository-specific module/attribute metadata and use Mathlib v4.34.0-rc2; the deprecated tactic lemmas `dif_pos`, `if_pos`, and `if_neg` are renamed to `dite_eq_left`, `ite_eq_left`, and `ite_eq_right`. No target definition or mathematical hypothesis is changed.
