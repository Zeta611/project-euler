open Core

let rec run_chain n =
  if n <= 1 || n = 89 then n
  else
    let rec sum_of_squares ?(acc = 0) = function
      | 0 -> acc
      | n ->
          let d = n mod 10 in
          sum_of_squares (n / 10) ~acc:(acc + (d * d))
    in
    run_chain (sum_of_squares n)

let () =
  let max = 10_000_000 in
  let rec count ?(cnt = 0) n =
    if n > max then cnt
    else count (n + 1) ~cnt:(if run_chain n = 89 then cnt + 1 else cnt)
  in
  Printf.printf "%d\n" (count 1)
