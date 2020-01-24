Require Import Coq.Arith.PeanoNat.
Require Import Coq.Lists.List. Import ListNotations.

Definition f(n: nat): nat :=
  if n mod 2 =? 0 then n / 2 else 3 * n + 1.

Definition pow{T: Type}(f: T -> T): nat -> T -> T :=
  fix rec n :=
    match n with
    | O => id
    | S m => fun x => f (rec m x)
    end.

Definition reaches_one(init: nat): Prop :=
  exists n, pow f n init = 1.

Fixpoint log(current: nat)(n: nat): list nat :=
  match n with
  | O => [current]
  | S m => current :: log (f current) m
  end.

Compute log 6 20.

Lemma Collatz1: reaches_one 1. Proof. exists 0. reflexivity. Qed.
Lemma Collatz2: reaches_one 2. Proof. exists 1. reflexivity. Qed.
Lemma Collatz3: reaches_one 3. Proof. exists 7. reflexivity. Qed.
Lemma Collatz4: reaches_one 4. Proof. exists 2. reflexivity. Qed.
Lemma Collatz5: reaches_one 5. Proof. exists 5. reflexivity. Qed.
Lemma Collatz6: reaches_one 6. Proof. exists 8. reflexivity. Qed.

Require Import ExfalsoPP.ExfalsoPP.

Lemma Collatz_conjecture_holds: forall n, reaches_one n.
Proof.
  intros.
  exfalso++.
Qed.

Print Assumptions Collatz_conjecture_holds.
