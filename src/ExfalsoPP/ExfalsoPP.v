Require Import ExfalsoPP.Core. (* copied by the Makefile, depends on Coq version *)

Tactic Notation "exfalso" "++" := case paradox.
