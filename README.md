# exfalso++

Proofs based on the _ex falso quod libet_ principle consist of two steps:

1. Apply the rule that from `False`, everything follows
2. Prove that the assumptions of our goal are contradictory

Unfortunately, Coq's `exfalso` tactic only performs step 1), but not step 2).
This library provides `exfalso++`, which also performs step 2), and does so **completely automatically**.
