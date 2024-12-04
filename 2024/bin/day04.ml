let lines = Aoc.read_lines "inputs/day04.txt"
let grid = List.map Aoc.string_to_char_list lines

let get_letter_from_grid grid x y =
  try List.nth (List.nth grid y) x with
  | _ -> '|'
;;

let xmas = 'X', 'M', 'A', 'S'

let compare_chars chars =
  (List.nth chars 0, List.nth chars 1, List.nth chars 2, List.nth chars 3)
  = xmas
;;

let compare_chars_p2 chars = 
  chars = [ 'M'; 'A'; 'S'; 'M'; 'A'; 'S'] || 
  chars = [ 'M'; 'A'; 'S'; 'S'; 'A'; 'M'] || 
  chars = [ 'S'; 'A'; 'M'; 'M'; 'A'; 'S'] || 
  chars = [ 'S'; 'A'; 'M'; 'S'; 'A'; 'M'] 

let get_chars grid x y dx dy =
  List.init 4 (fun i ->
    get_letter_from_grid grid (x + (i * dx)) (!y + (i * dy)))

let get_chars_p2 grid x y =
  [ get_letter_from_grid grid (x + 1) (!y + 1)
  ; get_letter_from_grid grid x !y
  ; get_letter_from_grid grid (x - 1) (!y - 1)
  ; get_letter_from_grid grid (x - 1) (!y + 1)
  ; get_letter_from_grid grid x !y
  ; get_letter_from_grid grid (x + 1) (!y - 1)
  ]
;;

let directions =
  [ (fun grid x y -> get_chars grid x y 1 0)
  ; (fun grid x y -> get_chars grid x y (-1) 0)
  ; (fun grid x y -> get_chars grid x y 0 1)
  ; (fun grid x y -> get_chars grid x y 0 (-1))
  ; (fun grid x y -> get_chars grid x y (-1) 1)
  ; (fun grid x y -> get_chars grid x y 1 1)
  ; (fun grid x y -> get_chars grid x y (-1) (-1))
  ; (fun grid x y -> get_chars grid x y 1 (-1))
  ]
;;

let directions_p2 =
  [ (fun grid x y -> get_chars_p2 grid x y)]
;;

let find_word grid x y =
  let results = List.map (fun f -> f grid x y) directions in
  List.map (fun chars -> compare_chars chars) results
  |> List.map Aoc.int_from_bool
  |> List.fold_left ( + ) 0
;;

let find_word_p2 grid x y =
  let results = List.map (fun f -> f grid x y) directions_p2 in
  List.map (fun chars -> compare_chars_p2 chars) results
  |> List.map Aoc.int_from_bool
  |> List.fold_left ( + ) 0
;;

let find_xmas grid =
  let count = ref 0
  and y = ref 0 in
  let rec iterate_over_list list x =
    match list with
    | [] -> ()
    | hd :: tl when hd = 'X' ->
      count := !count + find_word grid x y;
      iterate_over_list tl (x + 1)
    | _ :: tl -> iterate_over_list tl (x + 1)
  in
  let rec iterate_over_grid grid =
    match grid with
    | [] -> !count
    | hd :: tl ->
      iterate_over_list hd 0;
      y := !y + 1;
      iterate_over_grid tl
  in
  iterate_over_grid grid
;;

let find_xmas_p2 grid =
  let count = ref 0
  and y = ref 0 in
  let rec iterate_over_list list x =
    match list with
    | [] -> ()
    | hd :: tl when hd = 'A' ->
      count := !count + find_word_p2 grid x y;
      iterate_over_list tl (x + 1)
    | _ :: tl -> iterate_over_list tl (x + 1)
  in
  let rec iterate_over_grid grid =
    match grid with
    | [] -> !count
    | hd :: tl ->
      iterate_over_list hd 0;
      y := !y + 1;
      iterate_over_grid tl
  in
  iterate_over_grid grid
;;

let () = print_int (find_xmas grid)
let () = print_endline ""
let () = print_int (find_xmas_p2 grid)
