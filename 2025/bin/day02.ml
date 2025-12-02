let input = Aoc.read_all "inputs/day02.txt"

(* PART 1 *)

let get_range range_str =
  match String.split_on_char '-' range_str with
  | [s1; s2] ->
      (int_of_string (String.trim s1),
       int_of_string (String.trim s2))
  | _ ->
      failwith "Invalid range format"

let get_ranges input =
  let ranges = String.split_on_char ',' input in
  List.map get_range ranges

let detect_faulty_id id =  
  let id_str = string_of_int id in
  let length = String.length(id_str) in
  match length with
  | n when n mod 2 = 0 ->
                       begin
                         let first_half = String.sub id_str 0 (length/2) in
                         let second_half = String.sub id_str (length/2) (length/2) in
                         match String.compare first_half second_half with
                         | 0 -> int_of_string id_str
                         | _ -> 0
                       end
  | n when n mod 2 = 1 -> 0
  | _ -> 0

(* PART 2 *)

let are_all_equal (lst : string list) : bool =
  match lst with
  | [] | [_] -> true
  | head :: tail ->
      List.for_all (fun element -> element = head) tail

let split_by_length n s =
  let len = String.length s in
  let rec aux acc i =
    if i >= len then
      List.rev acc
    else
      let substr =
        let sub_len = min n (len - i) in
        String.sub s i sub_len
      in
      aux (substr :: acc) (i + n)
  in
  aux [] 0

let detect_faulty_id_p2 id =
  let id_str = string_of_int id in
  let len = String.length id_str in
  let rec aux i =
  if i > len/2 then
    0
  else
    let chunks = split_by_length i id_str in
    if are_all_equal chunks then
     (int_of_string id_str)
     else aux (i + 1)
  in
  aux 1

let get_faulty_ids (start, stop) detect_faulty_id =
  let range = List.init (stop-start+1) (fun x -> start+x) in
  List.fold_left (fun acc id -> acc + detect_faulty_id id) 0 range

let part1 =
  let ranges = get_ranges input in
  List.fold_left (fun acc range -> acc + get_faulty_ids range detect_faulty_id) 0 ranges

let part2 =
  let ranges = get_ranges input in
  List.fold_left (fun acc range -> acc + get_faulty_ids range detect_faulty_id_p2) 0 ranges

let () = Printf.printf "Part 1 solution: %d\n" part1
;;

let () = Printf.printf "Part 2 solution: %d\n" part2
;;

