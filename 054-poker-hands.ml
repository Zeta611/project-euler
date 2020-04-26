open Core

type value = N of int | J | Q | K | A [@@deriving eq, ord]
type suit = char
type card = value * suit
type rank = HighCard | OnePair | TwoPair | ThreeOfAKind | Straight | Flush
          | FullHouse | FourOfAKind | StraightFlush (* contains royal flush *)
          [@@deriving ord]
type score = rank * value list [@@deriving ord]

let get_suit : card -> suit = snd
let get_value : card -> value = fst
let eval_value = function
  | N n -> n
  | J -> 11
  | Q -> 12
  | K -> 13
  | A -> 14
let get_eval (card : card) = eval_value (get_value card)
let rev_sort l cmp = List.sort l (fun a b -> -(cmp a b))

let check_straight hand =
  let sorted = List.dedup_and_sort compare_int (List.map hand get_eval) in
  if List.length sorted <> 5 then false
  else if List.equal ( = ) sorted [2; 3; 4; 5; 14] then true
  else List.last_exn sorted - List.hd_exn sorted = 4

let check_flush hand = (
  hand
  |> List.map ~f:get_suit
  |> List.remove_consecutive_duplicates ~equal:equal_char
  |> List.length
) = 1

let get_kind (n : int) ?(except : value option = None) (hand : card list) =
  let values = List.map hand get_value in
  List.find values (fun v ->
    match except with
    | Some v' when equal_value v v' -> false
    | _ -> List.count values (equal_value v) = n
  )

let get_score hand =
  let values = rev_sort (List.map hand get_value) compare_value in
  let is_straight = check_straight hand in
  let is_flush = check_flush hand in
  if is_straight && is_flush then (StraightFlush, values) else
    match get_kind 4 hand with
    | Some v -> (FourOfAKind, v :: values)
    | None -> begin
        let three_of_a_kind = get_kind 3 hand in
        let pair = get_kind 2 hand in
        match three_of_a_kind, pair with
        | Some v1, Some v2 -> (FullHouse, [v1; v2])
        | _ when is_flush -> (Flush, values)
        | _ when is_straight -> (Straight, values)
        | Some v, None -> (ThreeOfAKind, v :: values)
        | None, Some v ->
          begin
            match get_kind 2 ~except:(Some v) hand with
            | Some v' -> (TwoPair, (rev_sort [v; v'] compare_value) @ values)
            | None -> (OnePair, v :: values)
          end
        | None, None -> (HighCard, values)
      end

let get_winner hand1 hand2 =
  match compare_score (get_score hand1) (get_score hand2) with
  | 1 -> 1
  | 0 -> 0
  | -1 -> 2
  | _ -> failwith "Impossible"

let parse str =
  let value = match str.[0] with
    | 'T' -> N 10
    | 'J' -> J
    | 'Q' -> Q
    | 'K' -> K
    | 'A' -> A
    | c -> N (Char.get_digit_exn c)
  in
  let suit = str.[1] in
  (value, suit)

let () =
  let wins =
    In_channel.read_lines "./054-poker.txt"
    |> List.map ~f:(fun line ->
      let cards = line |> String.split ~on:' ' |> List.map ~f:parse in
      let hand1, hand2 = List.split_n cards 5 in
      get_winner hand1 hand2
    )
    |> List.count ~f:(( = ) 1)
  in
  printf "Player 1 won %d times\n" wins
