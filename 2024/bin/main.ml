let lines = Aoc.read_all "inputs/day1.txt"
let string_to_char_list s = s |> String.to_seq |> List.of_seq

let update_floor brace current_floor =
  match brace with
  | '(' -> current_floor + 1
  | ')' -> current_floor - 1
  | _ -> current_floor
;;

let rec get_floor input current_floor =
  match input with
  | [] -> current_floor
  | brace :: braces ->
    let new_floor = update_floor brace current_floor in
    get_floor braces new_floor
;;

let rec get_basement_entrance input current_floor current_position =
  match current_floor with
  | -1 -> current_position
  | _ ->
    (match input with
     | [] -> current_position
     | brace :: braces ->
       let new_floor = update_floor brace current_floor in
       get_basement_entrance braces new_floor (current_position + 1))
;;

let () =
  let input_list = string_to_char_list lines in
  let floor = get_floor input_list 0 in
  let basement_entrance =
    get_basement_entrance input_list 0 0
  in
  Printf.printf "Part 1 solution: %d\n" floor;
  Printf.printf "Part 2 solution: %d\n" basement_entrance;
;;
