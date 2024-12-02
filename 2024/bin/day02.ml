let lines = Aoc.read_lines "inputs/day02.txt"

let get_levels line =
  List.map int_of_string (Str.split (Str.regexp "[ \t]+") line)
;;

let rec remove_last l = 
   match l with 
   | [] -> [] 
   | [_] -> [] 
   | hd::tl -> hd::(remove_last tl);;

let rec check_decreasing_level_safety level =
  match level with
  | [] -> true
  | [ x; y ] when (x <= y || x - y > 3) -> false
  | x :: y :: _ when (x <= y || x - y > 3) -> false
  | x :: y :: tl when x > y && x - y <= 3 ->
    check_decreasing_level_safety (y :: tl)
  | [ x; y ] when x > y && x - y <= 3 -> true
  | _ :: _ -> true
;;

let rec check_decreasing_level_safety_branch level =
  match level with
  | [] -> true
  | x :: y :: tl when (x <= y || x - y > 3) ->
    (check_decreasing_level_safety (x :: tl) || check_decreasing_level_safety (y :: tl))
  | x :: y :: tl when x > y && x - y <= 3 ->
    check_decreasing_level_safety_branch (y :: tl)
  | _ :: _ -> true
;;

let rec check_increasing_level_safety level =
  match level with
  | [] -> true
  | [ x; y ] when (x >= y || y - x > 3) -> false
  | x :: y :: _ when (x >= y || y - x > 3) -> false
  | x :: y :: tl when x < y && y - x <= 3 ->
    check_increasing_level_safety (y :: tl)
  | [ x; y ] when x < y && y - x <= 3 -> true
  | _ :: _ -> true
;;

let rec check_increasing_level_safety_branch level =
  match level with
  | [] -> true
  | x :: y :: tl when (x >= y || y - x > 3) ->
    (check_increasing_level_safety (y :: tl) || check_increasing_level_safety (x :: tl))
  | x :: y :: tl when x < y && y - x <= 3 ->
    check_increasing_level_safety_branch (y :: tl)
  | _ :: _ -> true
;;

let check_level_safety level =
  match level with
  | [] -> true
  | x :: y :: _ when x = y -> false
  | x :: y :: _ when x > y -> check_decreasing_level_safety level
  | x :: y :: _ when x < y -> check_increasing_level_safety level
  | _ :: _ -> true
;;

let check_level_safety_branch level =
  match level with
  | [] -> true
  | x :: y :: tl when x = y -> (check_level_safety (x::tl) || check_level_safety (y::tl))
  | x :: y :: _ when x > y -> check_decreasing_level_safety_branch level
  | x :: y :: _ when x < y -> check_increasing_level_safety_branch level
  | _ :: _ -> true
;;

(* Map `check_level_safety` with tolerance of 0 *)
let levels = List.map get_levels lines

let () = print_int (List.length (List.filter (fun level -> level = true) bools))
let () = print_endline ""
let () = print_int (List.length (List.filter (fun level -> level = true) bools_p2))
let () = print_endline ""
