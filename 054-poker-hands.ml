open Core
open Stdio

type value = N of int | J | Q | K | A [@@deriving ord,eq,show]
type suit = C | D | H | S [@@deriving ord,eq,show]
type card = value * suit [@@deriving ord,eq,show]
type hand = card list [@@deriving ord,eq,show]
type value_container =
  | Single of value
  | Double of value * value
  [@@deriving ord,eq,variants]
type rank =
  | HighCard of value_container
  | Pair of value_container
  | TwoPairs of value_container
  | ThreeOfAKind of value_container
  | Straight of value_container (* max value *)
  | Flush of value_container (* max value *)
  | FullHouse of value_container (* three of a kind value *)
  | FourOfAKind of value_container
  | StraightFlush of value_container (* max value *)
  | RoyalFlush
  [@@deriving ord,eq,variants]

exception Impossible
exception End_of_value
let rec incr = function
  | A -> raise End_of_value
  | K -> A
  | Q -> K
  | J -> Q
  | N 10 -> J
  | N v -> N (v + 1)

let sort_hand = List.sort ~compare:compare_card
let values_of = List.map ~f:fst
let suits_of = List.map ~f:snd
let count_values_in hand value =
  List.count (values_of hand) (equal_value value)

(* royal flush *)
let royal_flush_of suit = [N 10, suit; J, suit; Q, suit; K, suit; A, suit]
let check_royal_flush hand =
  let hand = sort_hand hand in
  let head = List.hd_exn hand in
  let suit = snd head in
  equal_hand hand (royal_flush_of suit)

(* straight flush *)
let check_straight_flush hand =
  let hand = sort_hand hand in
  let rec loop = function
    | [] -> raise Impossible
    | [v, s] -> Some (Single v)
    | (v1, s1) :: (v2, s2) :: tl ->
      if equal_value (incr v1) v2 && equal_suit s1 s2
      then loop ((v2, s2) :: tl)
      else None
  in
  loop hand

(* four of a kind *)
let check_four_of_a_kind hand =
  let dup = List.find_a_dup compare_value (values_of hand) in
  Option.bind dup (
    fun value ->
      if count_values_in hand value = 4 then Some (Single value) else None
  )

(* full house *)
let check_full_house hand =
  let dups = List.find_all_dups compare_value (values_of hand) in
  match dups with
  | [v1; v2] ->
    let count_v1 = count_values_in hand v1 in
    let count_v2 = count_values_in hand v2 in
    if count_v1 = 3 then Some (Single v1)
    else if count_v2 = 3 then Some (Single v2)
    else None
  | _ -> None

(* flush *)
let check_flush hand =
  let suit = snd (List.hd_exn hand) in
  if List.for_all (suits_of hand) (equal_suit suit)
  then Option.map (List.max_elt (values_of hand) compare_value) single
  else None

(* straight *)
let check_straight hand =
  let hand = List.sort hand compare_card in
  let values = values_of hand in
  let rec loop = function
    | [] -> raise Impossible
    | [v] -> Some (Single v)
    | v1 :: v2 :: tl ->
      if equal_value (incr v1) v2 then loop (v2 :: tl) else None
  in
  loop values

(* three of a kind *)
let check_three_of_a_kind hand =
  let dups = List.find_all_dups compare_value (values_of hand) in
  match dups with
  | [v] when count_values_in hand v = 3 -> Some (Single v)
  | _ -> None

(* two pairs *)
let check_two_pairs hand =
  let dups = List.find_all_dups compare_value (values_of hand) in
  match dups with
  | [v1; v2] ->
    let v1, v2 = if compare_value v1 v2 = 1 then (v1, v2) else (v2, v1) in
    Some (Double (v1, v2))
  | _ -> None

(* one pair *)
let check_pair hand =
  Option.map (List.find_a_dup compare_value (values_of hand)) single

(* high card *)
let get_high_card hand =
  match List.max_elt (values_of hand) compare_value with
  | Some v -> Single v
  | None -> raise Impossible


let rec nested_match fn_pattern_pairs final_fn_pattern_pair hand =
  match fn_pattern_pairs with
  | [] ->
    let fn, pattern = final_fn_pattern_pair in
    pattern (fn hand)
  | (fn, pattern)::tl ->
    match fn hand with
    | Some v -> pattern v
    | None -> nested_match tl final_fn_pattern_pair hand

let check_rank hand =
  if check_royal_flush hand then RoyalFlush
  else nested_match [
    check_straight_flush, straightflush;
    check_four_of_a_kind, fourofakind;
    check_full_house, fullhouse;
    check_flush, flush;
    check_straight, straight;
    check_three_of_a_kind, threeofakind;
    check_two_pairs, twopairs;
    check_pair, pair
  ] (get_high_card, highcard) hand

let determine_winner hand1 hand2 =
  match compare_rank (check_rank hand1) (check_rank hand2) with
  | 0 ->
    compare_hand
      (List.sort hand1 (fun c1 c2 -> -compare_card c1 c2))
      (List.sort hand2 (fun c1 c2 -> -compare_card c1 c2))
  | c -> c

let card_from_string str =
  let value = match str.[0] with
    | 'T' -> N 10
    | 'J' -> J
    | 'Q' -> Q
    | 'K' -> K
    | 'A' -> A
    | c -> N (Char.get_digit_exn c)
  in
  let suit = match str.[1] with
    | 'C' -> C
    | 'D' -> D
    | 'H' -> H
    | 'S' -> S
    | _ -> failwith "Unknown value"
  in
  (value, suit)

let win_count = In_channel.read_lines "./054-poker.txt"
  |> List.map ~f:(fun line ->
    let cards = line |> String.split ~on:' ' |> List.map ~f:card_from_string in
    let hand1, hand2 = List.split_n cards 5 in
    determine_winner hand1 hand2 = 1
  )
  |> List.count ~f:ident

let () = printf "Player 1 won %d times\n" win_count
