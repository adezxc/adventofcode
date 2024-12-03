let content = Aoc.read_all "inputs/day03.txt"

let find_muls mem =
  (* Str.Regexp compatible pattern that captures two groups *)
  let patt = Str.regexp {|mul(\([0-9]+\),\([0-9]+\))|}
  and group n = Str.matched_group n mem |> int_of_string in
  let rec parse idx pairs = try
      let jdx = Str.search_forward patt mem idx
      and pair = group 1, group 2 in
      parse (Int.succ jdx) (List.cons pair pairs)
    with
    | Not_found -> pairs
  in
  parse 0 []
;;

let calc_muls content =
  find_muls content |> List.fold_left (fun acc (a, b) -> acc + (a * b)) 0
;;

let () = print_int (calc_muls content)
let () = print_endline ""

let find_dont_index mem idx =
  let dont = Str.regexp {|don't()|} in
  try Str.search_forward dont mem idx with
  | Not_found -> String.length mem
;;

let find_do_index mem idx =
  let do_regex = Str.regexp {|do()|} in
  try Str.search_forward do_regex mem idx with
  | Not_found -> String.length mem
;;

let find_muls_p2 mem =
  (* Str.Regexp compatible pattern that captures two groups *)
  let patt = Str.regexp {|mul(\([0-9]+\),\([0-9]+\))|}
  and group n = Str.matched_group n mem |> int_of_string in
  let rec parse idx until_idx pairs =
    try
      (* Terminate if idx is beyond or equal to the content length *)
      if idx >= String.length mem then pairs
      else if idx <= until_idx then (
        let jdx = Str.search_forward patt mem idx 
        and pair = group 1, group 2 in
        if jdx > until_idx then 
        let new_idx = find_do_index mem until_idx in
        let new_until_idx = find_dont_index mem new_idx in
        parse new_idx new_until_idx pairs
        else parse (Int.succ jdx) until_idx (List.cons pair pairs))
      else (
        let new_idx = find_do_index mem until_idx in
        let new_until_idx = find_dont_index mem new_idx in
        parse new_idx new_until_idx pairs)
    with
    | Not_found -> pairs
  in
  parse 0 (find_dont_index mem 0) []
;;

let calc_muls_p2 content =
  find_muls_p2 content |> List.fold_left (fun acc (a, b) -> acc + (a * b)) 0
;;

let () = print_int (calc_muls_p2 content)
