let input = Aoc.read_lines "inputs/day04.txt"

type direction =
  | East
  | Southeast
  | South
  | Southwest
  | West
  | Northwest
  | North
  | Northeast

let dir_to_coord = function
  | East -> (0, 1)
  | Southeast -> (1, 1)
  | South -> (1, 0)
  | Southwest -> (1, -1)
  | West -> (0, -1)
  | Northwest -> (-1, -1)
  | North -> (-1, 0)
  | Northeast -> (-1, 1)

let dirs = [East; Southeast; South; Southwest; West; Northwest; North; Northeast]

let (+.) position direction =
  let (x1, y1) = position in
  let (x2, y2) = direction in
  (x1+x2, y1+y2)

let get_paper_roll grid position =
  let (x, y) = position in
  if x < 0 || y < 0 then
    '.'
  else List.nth (List.nth grid x) y 

let check_for_paper_roll grid position direction =
  let (x, y) = (position+.dir_to_coord(direction)) in
  if x < 0 || y < 0 then
    0
  else match List.nth_opt grid x with
  | Some x ->
           (match List.nth_opt x y with
           | Some x when x = '@' -> 1
           | Some _ -> 0
           | None -> 0)
  | None -> 0

let calc_paper_rolls grid position =
  if get_paper_roll grid position = '@'
  then
    if (List.fold_left (fun acc dir -> acc + (check_for_paper_roll grid position dir)) 0 dirs) < 4   
    then
      1
    else
    0
  else
  0

let part1 =
  let grid = List.map Aoc.explode input in
  let positions = List.init (List.length input) (fun x -> List.init (List.length (List.hd grid)) (fun y -> (x, y))) in
  List.fold_left (List.fold_left (fun acc pos -> acc + calc_paper_rolls grid pos)) 0 positions

let () = Printf.printf "Part 1 solution: %d\n" part1
;;

let check_for_paper_roll_p2 positions position direction =
  let (x, y) = (position+.dir_to_coord(direction)) in
  if x < 0 || y < 0 then
    0
  else match List.nth_opt positions x with
  | Some x ->
           (match List.nth_opt x y with
           | Some (_, _, x) when x = '@' -> 1
           | Some _ -> 0
           | None -> 0)
  | None -> 0

let calc_paper_rolls_p2 acc positions position =
  let (x, y, paper_roll) = position in
  if paper_roll = '@'
  then
    if (List.fold_left (fun acc dir -> acc + (check_for_paper_roll_p2 positions (x,y) dir)) 0 dirs) < 4   
    then
      (acc+1, (x, y, 'x'))
    else
    (acc, (x, y, paper_roll))
  else
  (acc, (x, y, paper_roll))

let calc_removed_row acc positions row =
  let (total, updated_row) = List.fold_left_map (fun acc pos -> calc_paper_rolls_p2 acc positions pos) 0 row
  in (total+acc, updated_row)

let calc_removed_grid positions =
  List.fold_left_map (fun acc row -> calc_removed_row acc positions row) 0 positions

let part2 =
  let grid = List.map Aoc.explode input in
  let positions = List.init
                   (List.length input)
                   (fun x -> List.init (List.length (List.hd grid))
                   (fun y -> (x, y, (get_paper_roll grid (x, y))))) in 
  let rec aux acc curr_positions =
    let (removed, new_positions) = calc_removed_grid curr_positions in
    if removed = 0 then
      acc
    else
      aux (acc+removed) new_positions
    in
    aux 0 positions

let () = Printf.printf "Part 2 solution: %d\n" part2
;;


  


