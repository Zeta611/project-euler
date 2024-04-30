open Core

let rec generate = function
  | [] -> []
  | [ x ] -> [ Float.of_int x ]
  | digits ->
      let open List.Let_syntax in
      let%bind d = digits in
      let rest = List.filter digits ~f:(( <> ) d) in
      let d = Float.of_int d in
      let%bind m = generate rest in
      let m = Float.round_decimal m ~decimal_digits:5 in
      let%bind v =
        match (d, m) with
        | 0., v | v, 0. -> [ v ]
        | d, m -> [ d +. m; d -. m; m -. d; d *. m; d /. m; m /. d ]
      in
      [ Float.round_decimal v ~decimal_digits:5 ]

let streak lst =
  let s = Set.of_list (module Float) lst in
  let rec check n =
    if not (Set.mem s (Float.of_int n)) then n - 1 else check (n + 1)
  in
  check 1

let () =
  let range x y = List.range x y ~start:`exclusive in
  let results =
    let open List.Let_syntax in
    let%bind a = range 0 10 in
    let%bind b = range a 10 in
    let%bind c = range b 10 in
    let%bind d = range c 10 in
    [ ((a, b, c, d), streak @@ generate [ a; b; c; d ]) ]
  in
  match
    List.max_elt results ~compare:(fun (_, n) (_, m) -> Int.compare n m)
  with
  | Some ((a, b, c, d), stk) -> printf "%d%d%d%d: %d\n" a b c d stk
  | None -> printf "\n"
