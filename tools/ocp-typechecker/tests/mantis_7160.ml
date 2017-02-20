(**************************************************************************)
(*                                                                        *)
(*   Typerex Tools                                                        *)
(*                                                                        *)
(*   Copyright 2011-2017 OCamlPro SAS                                     *)
(*                                                                        *)
(*   All rights reserved.  This file is distributed under the terms of    *)
(*   the GNU General Public License version 3 described in the file       *)
(*   LICENSE.                                                             *)
(*                                                                        *)
(**************************************************************************)

(* OCaml version 4.03.0+beta1*)
type 'a any = [< `A | `B] as 'a;;
(* type 'a any = 'a constraint 'a = [< `A | `B ] *)
type _ t = X : int -> [`A] t | Y : string -> [`B] t | C : (_ any as 'l) t -> 'l t;;
(* type _ t =
    X : int -> [ `A ] t
  | Y : string -> [ `B ] t
  | C : 'a any t -> ([< `A | `B ] as 'a) any t *)
let rec f = function Y s -> s | C y -> f y;;
(* val f : [ `B ] any t -> string = <fun> *)
(* f (Y "5");; *)
(* (\* - : string = "5" *\) *)
(* f (C (Y "5"));; *)
(* (\* - : string = "5" *\) *)
(* f (X 5);; *)
(* (\* Error: This expression has type [ `A ] t *)
(*        but an expression was expected of type [ `B ] any t *)
(*        Type [ `A ] is not compatible with type [ `B ] any = [ `B ]  *)
(*        These two variant types have no intersection *\) *)
(* f (C (X 5));; *)
(* (\* Error: This expression has type [ `A ] t *)
(*        but an expression was expected of type [ `B ] any any t *)
(*        Type [ `A ] is not compatible with type [ `B ] any any = [ `B ]  *)
(*        These two variant types have no intersection *\) *)
(* (\* Until now everything is OK *\) *)
(* type 'a tt = 'a t = X : int -> [`A] tt | Y : string -> [`B] tt | C : [< `A | `B] t -> [< `A | `B] tt;; *)
(* (\* type 'a tt = *)
(*   'a t = *)
(*     X : int -> [ `A ] tt *)
(*   | Y : string -> [ `B ] tt *)
(*   | C : [< `A | `B ] t -> [< `A | `B ] tt *\) *)
(* (\* This type synonym definition is accepted though its constraints for the C constructor are different (no equality previously expressed with variable 'l) *\) *)
(* (\* Now even the definition of type _ t itself is changed *\) *)
(* f (Y "5");; *)
(* (\* - : string = "5" *\) *)
(* f (C (Y "5"));; *)
(* (\* - : string = "5" *\) *)
(* f (X 5);; *)
(* (\* Error: This expression has type [ `A ] tt = [ `A ] t *)
(*        but an expression was expected of type [ `B ] any t *)
(*        Type [ `A ] is not compatible with type [ `B ] any = [ `B ]  *)
(*        These two variant types have no intersection *\) *)
(* (\* The following should not be accepted *\) *)
(* f (C (X 5));; *)
