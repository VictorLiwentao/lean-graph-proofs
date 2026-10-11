# Verification

Fresh checks completed October 10, 2026 (America/Chicago), using Lean/Mathlib v4.34.0-rc2. All three proof modules, their shared support and the combined library compiled with warnings treated as errors.

| Target | Original statement match | Dependent definitions | Allowed axioms | Fresh Lean kernel replay |
| --- | --- | --- | --- | --- |
| WOWII 101 | Passed | Passed | Standard three only | Passed |
| WOWII 20 | Passed | Passed | Standard three only | Passed |
| WOWII 7 | Passed | Passed | Standard three only | Passed |

The [current report](current.json) includes original-source pins, exact Comparator configurations, challenge declarations, solution wrappers, proof/export hashes and complete check logs. The allowed axioms are `propext`, `Classical.choice`, and `Quot.sound`.

## Statement fidelity

Challenges are extracted from DeepMind commit `4c40439d9be65b242e9196fb7848be02a9a4481d`. Target types and graph definitions are preserved. Repository-only module/attribute metadata and imports are adapted to the pinned Mathlib environment, and unrelated sanity examples are omitted. Solution wrappers apply the published proofs to those original declarations.

The WOWII 101 deletion/core definitions are copied directly from the original statement. Shared graph definitions come from the same DeepMind commit. The original research proof bodies are preserved, apart from deprecated tactic-lemma spellings (`dif_pos`, `if_pos`, `if_neg`) updated for Mathlib v4.34.0-rc2. No admitted target theorem is imported by the proofs.

## DeepMind toolchain compatibility

The original research proof sources were also freshly compiled with DeepMind's own Lean v4.33.1 and current pinned dependencies. Exact-statement wrappers for all three targets typechecked against the current DeepMind modules, and their axiom lists contain only the same three standard axioms. These are additional native-toolchain checks; the Comparator run above uses v4.34.0-rc2. The logs and source hashes are included in `current.json`.

## Comparator

[Comparator](https://github.com/leanprover/comparator) commit `ca04cfc72b550331658ec314bf47685281bfd4bf` and compatible lean4export commit `cacf989bd75f608700820f6afc595f32e7a99a4d` were used. The comparison/axiom-checking code and the upstream built-in kernel replay functions are unchanged.

The macOS runner replaces process orchestration with Python/direct Lean and `#eval` entry points because the local Lean IO-main/Lake runtime traps. It uses `sandbox-exec` to restrict network and writes, rather than Linux Landrun. No external kernel is used. Existing pinned Mathlib caches are trusted; dependency commits and clean tracked files were checked again.

Controls accepted a valid proof and rejected a changed theorem, an extra axiom, and a changed definition at the Comparator stage.

## Reproduce

Use `lake exe cache get` and `lake --wfail build LeanGraphProofs` on a normal Lean installation. If the local Lake runtime fails after the dependencies are already installed, `python3 scripts/check.py` compiles all local modules directly with the pinned Lean compiler and prints the three theorem axiom lists.

To repeat Comparator, materialize each target's `challenge_source`, `solution_wrapper` and `config` from `current.json` in an audit project alongside this library, and run the pinned Comparator against each config. The challenge's admitted theorem is intentional; the solution must have none. The report documents the exact adapted macOS run used here.
