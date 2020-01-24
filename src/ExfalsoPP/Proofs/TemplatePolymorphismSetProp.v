(* from https://github.com/coq/coq/issues/9294#issuecomment-450860504 *)

Inductive Foo@{i} (A:Type@{i}) : Type := foo : (Set:Type@{i}) -> Foo A.
Arguments foo {_} _.

Definition bar : Foo True -> Set := fun '(foo x) => x.

Definition foo_bar (n : Foo True) : foo (bar n) = n.
Proof. destruct n;reflexivity. Qed.

Definition bar_foo (n : Set) : bar (foo n) = n.
Proof. reflexivity. Qed.

Require Import Hurkens.

Inductive box (A : Set) : Prop := Box : A -> box A.

Definition paradox : False.
Proof.
unshelve refine (
  NoRetractFromSmallPropositionToProp.paradox
  (Foo True)
  (fun A => foo A)
  (fun A => box (bar A))
  _
  _
  False
).
+ cbn; intros A [x]; exact x.
+ cbn; intros A x; refine (Box _ x).
Qed.

Check paradox.
Print Assumptions paradox.
