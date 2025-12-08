let input = Aoc.read_lines "inputs/day05.txt"

let is_range input =
  String.contains input '-'

let is_number input =
  match int_of_string_opt input with
  | Some _ -> true
  | None -> false

let valid_range start stop number =
  number >= start && number <= stop
  
let get_range input =
  let range_strs = String.split_on_char '-' input in
  match range_strs with
  | [start_s; stop_s] -> 
      valid_range (int_of_string start_s) (int_of_string stop_s)
  | _ -> failwith "Invalid range format"

let parse_input input =
  let rec aux input valid_ranges ids =
  match input with
  | x :: xs when is_range x ->
      aux xs ((get_range x) :: valid_ranges) ids 
  | x :: xs when is_number x ->
      aux xs valid_ranges ((int_of_string x) :: ids)
  | _ :: xs -> aux xs valid_ranges ids  
  | [] -> (valid_ranges, ids) 
  in aux input [] []

let part1 =
  let (valid_ranges, ids) = parse_input input in
  List.fold_left (fun acc elem -> 
    if List.exists (fun range -> range elem) valid_ranges then
      (acc + 1)
    else
      acc
  ) 0 ids

let () = Printf.printf "Part 1 solution: %d\n" part1
;;

(* PART2 *)
  
let get_range_p2 input =
  let range_strs = String.split_on_char '-' input in
  match range_strs with
  | [start_s; stop_s] -> 
   (int_of_string(start_s), int_of_string(stop_s)) 
  | _ -> failwith "Invalid range format"


let overlaps (start1, end1) (start2, end2) =
  start1 <= end2 && start2 <= end1

let merge (start1, end1) (start2, end2) =
  (min start1 start2, max end1 end2)


let add_range_merged new_range existing_ranges =
  let rec aux curr rest acc =
    match rest with
    | [] -> 
        curr :: acc
    | x :: xs ->
        if overlaps curr x then
          let combined = merge curr x in
          aux combined xs acc
        else
          aux curr xs (x :: acc)
  in
  aux new_range existing_ranges []
  
let parse_input_p2 input =
  let rec aux input ranges =
  match input with
  | x :: xs when is_range x -> aux xs (add_range_merged (get_range_p2 x) ranges)
  | _ :: _ -> ranges 
  | [] -> ranges 
  in aux input []

let part2 =
  let ranges = parse_input_p2 input in
  List.fold_left (
    fun acc elem ->
    let (start, stop) = elem in
    let _ = Printf.printf "Start %d  end %d\n" start stop in
      acc + (stop+1-start)
    )
    0
    ranges

let () = Printf.printf "Part 2 solution: %d\n" part2
;;

