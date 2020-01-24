# exfalso++ [![Build Status](https://travis-ci.com/samuelgruetter/ExfalsoPP.svg?branch=master)](https://travis-ci.com/samuelgruetter/ExfalsoPP)

Proofs based on the _ex falso quod libet_ principle consist of two steps:

1. Apply the rule that from `False`, everything follows
2. Prove that the assumptions of our goal are contradictory

Unfortunately, Coq's `exfalso` tactic only performs step 1), but not step 2).
This library provides `exfalso++`, which also performs step 2), and does so **completely automatically**.

## Supported versions

Our goal is to support as many Coq versions as possible, but since there are significant differences between the various Coq versions, this is a challenging goal. At the moment, we support:

* Coq 8.9.0
* Coq 8.10.2
