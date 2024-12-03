let lines = Aoc.read_lines "inputs/day02.txt"

let get_levels line =
  List.map int_of_string (Str.split (Str.regexp "[ \t]+") line)
;;

let levels = List.map get_levels lines

(* Check if a list is strictly increasing with differences between 1 and 3 *)
let is_increasing lst =
  let rec aux prev = function
    | [] -> true
    | x :: xs -> (x > prev && x - prev <= 3) && aux x xs
  in
  match lst with
  | [] | [ _ ] -> true (* Empty or single-element list is trivially safe *)
  | x :: xs -> aux x xs
;;

(* Check if a list is strictly decreasing with differences between 1 and 3 *)
let is_decreasing lst =
  let rec aux prev = function
    | [] -> true
    | x :: xs -> (prev > x && prev - x <= 3) && aux x xs
  in
  match lst with
  | [] | [ _ ] -> true (* Empty or single-element list is trivially safe *)
  | x :: xs -> aux x xs
;;

(* Check if a list is safe (increasing or decreasing) *)
let is_safe lst = is_increasing lst || is_decreasing lst

let is_safe_with_dampener lst =
  let rec aux idx =
    if idx >= List.length lst
    then false
    else (
      let filtered = List.filteri (fun i _ -> i <> idx) lst in
      if is_safe filtered then true else aux (idx + 1))
  in
  is_safe lst || aux 0
;;

(* Count safe reports *)
let count_safe_reports reports =
  List.fold_left
    (fun acc report -> if is_safe report then acc + 1 else acc)
    0
    reports
;;

(* Count safe reports with the Problem Dampener *)
let count_safe_reports_with_dampener reports =
  List.fold_left
    (fun acc report -> if is_safe_with_dampener report then acc + 1 else acc)
    0
    reports
;;

(* Example usage *)
let () =
  let safe_reports_part1 = count_safe_reports levels in
  let safe_reports_part2 = count_safe_reports_with_dampener levels in
  Printf.printf "Part 1: %d\n" safe_reports_part1;
  Printf.printf "Part 2: %d\n" safe_reports_part2
;;
