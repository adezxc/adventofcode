module IntMap = Map.Make (Int)

let rec is_sublist main_list sub_list =
  match sub_list with
  | [] -> false
  | head :: tail ->
    if List.exists (fun i -> head == i) main_list
    then true
    else is_sublist main_list tail

;;

let read_rules_and_updates filename =
  let ic = open_in filename in
  let rec read_lines_until_empty_line ic lines =
    try
      match input_line ic with
      | "" -> List.rev lines (* Stop reading and return the accumulated lines *)
      | line -> read_lines_until_empty_line ic (line :: lines)
    with
    | End_of_file -> List.rev lines
  in
  let rules = read_lines_until_empty_line ic [] in
  let string_updates = read_lines_until_empty_line ic [] in
  let updates =
    List.map
      (fun update -> List.map int_of_string (String.split_on_char ',' update))
      string_updates
  in
  close_in ic;
  (* Close the input channel *)
  rules, updates
;;

let partial_sort m case =
  List.sort
    (fun i j ->
      let pages_needed_i = IntMap.find_opt i m in
      let pages_needed_j = IntMap.find_opt j m in
      match pages_needed_i, pages_needed_j with
      | None, None -> 0
      | Some _, None -> 1
      | None, Some _ -> -1
      | Some pages_i, Some _ ->
        if List.exists (fun i -> i == j) pages_i then 1 else -1)
    case
;;

let add_rule_to_map (m : int list IntMap.t) rule =
  let num1, num2 = Scanf.sscanf rule "%d|%d" (fun n2 n1 -> n2, n1) in
  let existing_rules =
    IntMap.update
      num1
      (fun l ->
        match l with
        | None -> Some [ num2 ]
        | Some existing_rules -> Some (num2 :: existing_rules))
      m
  in
  existing_rules
;;

let is_case_valid map nums =
  let rec loop map prev_nums remaining_nums =
    match remaining_nums with
    | [] -> true
    | head :: tail ->
      let allowed = IntMap.find_opt head map in
      (match allowed with
       | None -> loop map (head :: prev_nums) tail
       | Some allowed_checked ->
         if is_sublist allowed_checked prev_nums
         then false
         else loop map (head :: prev_nums) tail)
  in
  loop map [] nums
;;

(*
   75,47,61,53,29

   1. We take 75, and there's no rules to check
   2. We take 47, and check that there are no rules
   that say that 47 needs to be before 75
   3. We take 61, and check that there is no rule which
   says that 61 needs to be before 75 OR 61 needs to be before 47
*)
let rule_map : int list IntMap.t = IntMap.empty in
let rules, updates = read_rules_and_updates "inputs/day05.txt" in
let map_with_rules = List.fold_left add_rule_to_map rule_map rules in
let part1 =
  List.fold_left
    (fun acc update ->
      if is_case_valid map_with_rules update
      then acc + List.nth update (List.length update / 2)
      else acc)
    0
    updates
in
let () = Printf.printf "Part 1: %d" part1 in
let invalid_updates =
  List.filter (fun update -> not (is_case_valid map_with_rules update)) updates
in
let sorted_invalid_updates =
  List.map (fun case -> partial_sort map_with_rules case) invalid_updates
in
let part2 =
  List.fold_left
    (fun acc update ->
      if not (is_case_valid map_with_rules update)
      then acc + List.nth update (List.length update / 2)
      else acc)
    0
    sorted_invalid_updates
in
Printf.printf "Part 2: %d" part2
