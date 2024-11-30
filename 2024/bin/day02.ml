let lines = Aoc.read_lines "inputs/day02.txt"

let get_dimensions line =
  let dim_list = String.split_on_char 'x' line in
  ( int_of_string (List.nth dim_list 0)
  , int_of_string (List.nth dim_list 1)
  , int_of_string (List.nth dim_list 2) )
;;

let find_smallest_face (x, y, z) =
  match x, y, z with
  | x, y, z when x <= z && y <= z -> (2 * x) + (2 * y)
  | x, y, z when x <= y && z <= y -> (2 * x) + (2 * z)
  | x, y, z when y <= x && z <= x -> (2 * y) + (2 * z)
  | _ -> x * y
;;

let calc_extra (x, y, z) =
  match x, y, z with
  | x, y, z when x <= z && y <= z -> x * y
  | x, y, z when x <= y && z <= y -> x * z
  | x, y, z when y <= x && z <= x -> y * z
  | _ -> x * y
;;

let calc_area (x, y, z) = (2 * x * y) + (2 * y * z) + (2 * x * z)
let calc_volume (x, y, z) = x * y * z

let () =
  Printf.printf
    "Part 1 solution: %d\n"
    (List.fold_left
       (fun acc line ->
         let dims = get_dimensions line in
         acc + calc_area dims + calc_extra dims)
       0
       lines)
;;

let () =
  Printf.printf
    "Part 2 solution: %d\n"
    (List.fold_left
       (fun acc line ->
         let dims = get_dimensions line in
         acc + calc_volume dims + find_smallest_face dims)
       0
       lines)
;;
