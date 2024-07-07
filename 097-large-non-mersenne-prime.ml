open! Core

let threshold = Z.of_int 10_000_000_000
let ( = ) = Z.equal
let ( >= ) = Z.geq
let two = Z.of_int 2

let trunc (n : Z.t) : Z.t =
  let open Z in
  if n >= threshold then n mod threshold else n

let rec pow_2 (n : Z.t) : Z.t =
  let open Z in
  if n = zero then one
  else if n mod two = zero then
    let x = trunc (pow_2 (n / two)) in
    trunc (x * x)
  else
    let x = trunc (pow_2 (n / two)) in
    trunc (two * trunc (x * x))

let () =
  let open Z in
  let a = of_int 28433 in
  let b = of_int 7830457 in
  printf "%d\n" (to_int (trunc (trunc (a * pow_2 b) + one)))
