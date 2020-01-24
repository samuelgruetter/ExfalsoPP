(* from https://github.com/coq/coq/pull/11422#issuecomment-576858814 *)

Require Import Coq.Logic.Hurkens.

Section Paradox.

(** ** Universe [U] is equal to one of its elements. *)

Polymorphic Definition plus1@{u} := Type@{u+1}.
Let Set1 := Eval cbv in plus1@{Set}.
Let U : Type := Set1.
Let A:U := Set1.
Let h : U=A := eq_refl Set1.

(** ** Universe [U] is a retract of [A] *)

(** The following context is actually sufficient for the paradox to
    hold. The hypothesis [h:U=A] is only used to define [down], [up]
    and [up_down]. *)

Let down (X:U) : A := @eq_rect _ _ (fun X => X) X _ h.
Let up   (X:A) : U := @eq_rect_r _ _ (fun X => X) X _ h.

Lemma up_down : forall (X:U), up (down X) = X.
Proof.
  unfold up,down.
  rewrite <- h.
  reflexivity.
Qed.

Theorem paradox : False.
Proof.
  clearbody A h.
  Generic.paradox p.
  (** Large universe *)
  + exact U.
  + exact (fun X=>X).
  + cbn. exact (fun X F => forall x:X, F x).
  + cbn. exact (fun _ _ x => x).
  + cbn. exact (fun _ _ x => x).
  + exact (fun F => forall x:A, F (up x)).
  + cbn. exact (fun _ f => fun x:A => f (up x)).
  + cbn. intros * f X.
    specialize (f (down X)).
    rewrite up_down in f.
    exact f.
  (** Small universe *)
  + exact A.
  (** The interpretation of [A] as a universe is [U]. *)
  + cbn. exact up.
  + cbn. refine (fun u F => down _). cbv. exact_no_check (forall x, up (F x)). (* no_check to get around "algebraic universe on the right" *)
  + cbn. refine (fun u F => down _). cbv. exact_no_check (forall x, up (F x)). (* no_check to get around "algebraic universe on the right" *)
  + cbn. exact (down False).
  + rewrite up_down in p.
    exact p.
  + cbn. easy.
  + cbn. intros ? f X.
    destruct (up_down X). cbn.
    reflexivity.
  + cbn. intros ? ? f.
    rewrite up_down.
    exact f.
  + cbn. intros ? ? f.
    rewrite up_down in f.
    exact f.
  + cbn. intros ? ? f.
    rewrite up_down.
    exact f.
  + cbn. intros ? ? f.
    rewrite up_down in f.
    exact f.
Qed.

End Paradox.

Check paradox.
Print Assumptions paradox.
