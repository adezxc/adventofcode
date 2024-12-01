let lines = Aoc.read_lines "inputs/day01.txt"

(* Text Processing *)

let get_locations line =
  List.map int_of_string (Str.split (Str.regexp "[ \t]+") line)
;;

let rec get_location_lists lines first_col second_col =
  match lines with
  | [] -> first_col, second_col
  | line :: rest ->
    (match get_locations line with
     | loc1 :: loc2 :: _ ->
       get_location_lists rest (loc1 :: first_col) (loc2 :: second_col)
     | _ -> get_location_lists rest [] [])
;;

let first_list, second_list = get_location_lists lines [] []

(* Part 1 *)

let sort_and_sum_diffs =
  let sorted_first = List.sort compare first_list in
  let sorted_second = List.sort compare second_list in
  List.fold_left2
    (fun acc a b -> acc + abs (a - b))
    0
    sorted_first
    sorted_second
;;

let () = Printf.printf "Part 1 solution: %d\n" sort_and_sum_diffs

(* Part 2 *)
let add freq x y = if y = x then freq y + 1 else freq y

let calculate_frequencies lst =
  let initial_freq _ = 0 in
  List.fold_left add initial_freq lst
;;

let calc_part_2 = 
  let list_freq = calculate_frequencies second_list in
  List.fold_left (fun acc a -> acc + (list_freq a) * a) 0 first_list 

let () = Printf.printf "Part 2 solution: %d\n" calc_part_2
