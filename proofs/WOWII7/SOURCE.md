# WOWII7: sources and attribution

**Mathematics:** Ermelinda DeLaVina, Siemion Fajtlowicz and Bill Waller, [On Some Conjectures of Griggs and Graffiti](https://www.uhd.edu/documents/academics/sciences/griggsngraffiti.pdf), March 2002, revised May 2003, Conjecture 2 and Lemma 1.

**Lean proof and write-up:** Wentao Li, 2026, with AI assistance.
**Original Lean statement and shared graph definitions:** The Formal Conjectures Authors, Apache-2.0.

- [Current statement used for comparison](https://github.com/google-deepmind/formal-conjectures/blob/4c40439d9be65b242e9196fb7848be02a9a4481d/FormalConjectures/WrittenOnTheWallII/GraphConjecture7.lean).
- [Original research proof](https://github.com/VictorLiwentao/formal-conjectures/blob/80a5b6480f5237d5580f673bb4ab059bbdcc4058/research/batches/b01/workers/cursor-07-r05/targets/WOWII7/WOWII7.lean); SHA-256 `c85feea04b8babc79e8fd9a5c227f74ed725534edaa101a63f7e4d0ef1e3244c`.
- [Canonical published Lean proof](../../LeanGraphProofs/WOWII7.lean), declaration `WOWII7.conjecture7`.
- [Readable proof](PROOF.md) and [verification procedure](../../verification/README.md).

The theorem retains the original finite-type, nontriviality and connectedness hypotheses. The current DeepMind target is compared to a wrapper applying this proof, including its dependent definitions.

The local support modules preserve the original graph definitions. Packaging changes remove repository-specific module/attribute metadata and use Mathlib v4.34.0-rc2; the deprecated tactic lemmas `dif_pos`, `if_pos`, and `if_neg` are renamed to `dite_eq_left`, `ite_eq_left`, and `ite_eq_right`. No target definition or mathematical hypothesis is changed.
