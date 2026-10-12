# WOWII 291: a twelve-vertex counterexample

Formalization: Wentao Li, with OpenAI Codex assistance. The graph is the m=6 member of the family documented by `vulnix0x4` in [issue #4562](https://github.com/google-deepmind/formal-conjectures/issues/4562). The WOWII source credits Zyad Tamimi with the known refutation. We do not assert that the two recorded graphs are identical.

Use vertices a,b,x1,…,x6,p,q,r,leaf. Start with the book graph whose spine is ab and whose six pages are abxi. Add px1, pb, qx1, qa, qleaf, x2x3, rx2, and rx3. This is a connected graph on twelve vertices with 21 edges.

The incident triangle counts are [8,8,3,4,4,1,1,1,1,1,1,0], so the leaf is the unique vertex attaining the minimum. The descending degree sequence is [8,8,4,4,4,3,2,2,2,2,2,1]. Its first two Havel–Hakimi reductions are [7,3,3,3,2,2,2,1,1,1,1] and [2,2,2,1,1,1,1,1,1,0]. The first zero therefore appears at step two.

The set {q,a,x1,x2} totally dominates. Every total dominating set must contain q for the leaf, a member of {x2,x3} for r, and a member of {a,b} for x4. If it contains a, domination of p needs another member from {b,x1}; if it contains b, domination of q needs another member from {a,x1,leaf}. In either case these are four distinct vertices. Thus total domination is four, contradicting the proposed bound 4≤2+1.

Lean kernel certificates establish the edge list, connectivity, degrees, triangle counts, reductions and explicit neighborhoods. The lower domination bound is structural. Each noncomputable minimum is proved from a witness and a lower bound. The five original target definitions retain their exact values, including multiset degree multiplicities and iteration zero.

Canonical module: `LeanGraphProofs.WOWII291`. Main theorem: `ResearchWOWII291.conjecture291`. This negates the entire universal statement, including the n>2 hypothesis. Its axioms are `propext`, `Classical.choice`, and `Quot.sound`. The public package uses Lean/Mathlib v4.34.0-rc2; exact correspondence is also checked on DeepMind's pinned Lean 4.33.1. See [verification](../../verification/README.md).
