let lines = Aoc.read_lines "inputs/day01.txt"

(* Text processing *)
let get_rotation line =
  let direction = String.get line 0 in 
  let rotation = int_of_string (Str.string_after line 1) in
  let _ = Printf.printf "rotation is %s\n" line in
  match direction with
  | 'L' -> -rotation
  | 'R' -> rotation
  | _ -> 0
;;

let handle_rotation (position,  password) line =
  let new_position = position + get_rotation(line) in
  match new_position with
  | n when n mod 100 = 0 -> (0, password+1)
  | n when n < 0 -> (100 - abs(new_position mod 100) , password) 
  | n when n > 99 -> (new_position mod 100, password)
  | _ -> (new_position, password)
;;

let handle_rotation_p2 (position,  password) line =
  let new_position = position + get_rotation(line) in
  let _ = Printf.printf "old is %d new is %d password: %d\n" position new_position password in
  match new_position, position with
  | 0, _ -> (0, password+1)
  | n, m when n < 0 && m != 0 -> ((100 - abs(n mod 100)) mod 100 , password+1-(n/100))
  | n, m when n < 0 && m == 0 -> ((100 - abs(n mod 100)) mod 100 , password-(n/100))
  | n, _ when n > 99 -> (n mod 100, password+(n/100))
  | _, _ -> (new_position, password)
;;

let part1 =
  let (_, password) = List.fold_left handle_rotation (50, 0) lines in
  password
;;

let part2 =
  let (_, password) = List.fold_left handle_rotation_p2 (50, 0) lines in
  password
;;

let () = Printf.printf "Part 1 solution: %d\n" part1
;;

let () = Printf.printf "Part 2 solution: %d\n" part2
;;
