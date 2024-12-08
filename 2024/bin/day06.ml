type block_type =
  | Empty
  | Guard
  | Obstruction

type direction =
  | Up
  | Down
  | Left
  | Right

let rotate (d : direction) : direction =
  let directions = [ Up; Right; Down; Left ] in
  match List.find_index (fun dir -> d == dir) directions with
  | Some x ->
    let index = (x + 1) mod 4 in
    List.nth directions index
  | None -> raise (Invalid_argument "wtf")
;;

type coordinate =
  { x : int
  ; y : int
  }

type coordinate_with_direction =
  { coord : coordinate
  ; direction : direction
  }

module CoordinateSet = Set.Make (struct
    type t = coordinate

    let compare c1 c2 =
      match compare c1.x c2.x with
      | 0 -> compare c1.y c2.y
      | cmp -> cmp
    ;;
  end)

module CoordinateWithDirectionSet = Set.Make (struct
    type t = coordinate_with_direction

    let compare_direction d1 d2 =
      match d1, d2 with
      | Up, Up | Down, Down | Left, Left | Right, Right -> 0
      | Up, (Left | Down | Right) -> 1
      | Right, (Left | Down) -> 1
      | Down, Left -> 1
      | (Left | Down | Right), Up -> -1
      | (Down | Left), Right -> -1
      | Left, Down -> -1
    ;;

    let compare c1 c2 =
      match compare c1.coord.x c2.coord.x with
      | 0 ->
        (match compare c1.coord.y c2.coord.y with
         | 0 -> compare_direction c1.direction c2.direction
         | cmp -> cmp)
      | cmp -> cmp
    ;;
  end)

let add_coords a b = { x = a.x + b.x; y = a.y + b.y }

let direction_to_movement = function
  | Up -> { x = 0; y = -1 }
  | Down -> { x = 0; y = 1 }
  | Left -> { x = -1; y = 0 }
  | Right -> { x = 1; y = 0 }
;;

let direction_to_string = function
  | Up -> "UP"
  | Down -> "Down"
  | Left -> "Left"
  | Right -> "Right"
;;

let char_to_block_type = function
  | '.' -> Some Empty
  | '#' -> Some Obstruction
  | '^' -> Some Guard
  | _ -> raise (Invalid_argument "bad block type")
;;

let block_type_to_char = function
  | Some Empty -> '.'
  | Some Obstruction -> '#'
  | Some Guard -> '^'
  | None -> raise (Invalid_argument "AAAAA")
;;

let get_guard_coordinates gamestate =
  let rec loop gamestate y =
    match gamestate with
    | [] -> raise (Invalid_argument "wtf2")
    | head :: tail ->
      (match List.find_index (fun block -> block = Some Guard) head with
       | None -> loop tail (y + 1)
       | Some idx -> { x = idx; y })
  in
  loop gamestate 0
;;

let get_block_by_coordinates gamestate coord =
  if coord.y < 0 || coord.x < 0
  then None
  else (
    match List.nth_opt gamestate coord.y with
    | None -> None
    | Some y ->
      (match List.nth_opt y coord.x with
       | None -> None
       | Some x -> x))
;;

let print_gamestate gamestate =
  let print_row row =
    let () =
      List.iter
        (fun block ->
          let char = block_type_to_char block in
          print_char char)
        row
    in
    print_endline ""
  in
  List.iter print_row gamestate
;;

let read_gamestate filename =
  let lines = Aoc.read_lines filename in
  Some
    (List.map
       (fun line ->
         String.to_seq line
         |> Seq.map (fun c ->
           match char_to_block_type c with
           | Some value ->
             Some value (* Assuming char_to_block_type returns an option type *)
           | None -> None)
         |> List.of_seq)
       lines)
;;

let modify_gamestate gamestate row col =
  let rec update_row r lst =
    match lst with
    | [] -> []
    | h :: t ->
      if r = 0
      then (
        match h with
        | Some Guard -> h :: t
        | Some Obstruction -> h :: t
        | Some Empty -> Some Obstruction :: t
        | None -> h :: t)
      else h :: update_row (r - 1) t
  in
  let rec update_grid r lst =
    match lst with
    | [] -> []
    | h :: t ->
      if r = 0 then update_row col h :: t else h :: update_grid (r - 1) t
  in
  if row < 0
     || col < 0
     || row >= List.length gamestate
     || col >= List.length (List.nth gamestate 0)
  then gamestate (* Return unchanged if coordinates are out of bounds *)
  else update_grid row gamestate
;;

let generate_all_modifications grid =
  let rec aux row col acc =
    if row >= List.length grid
    then acc
    else if col >= List.length (List.nth grid row)
    then aux (row + 1) 0 acc
    else (
      match List.nth (List.nth grid row) col with
      | Some Guard -> aux row (col + 1) acc
      | Some Obstruction -> aux row (col + 1) acc
      | Some Empty ->
        let modified_grid = modify_gamestate grid row col in
        aux row (col + 1) (modified_grid :: acc)
      | None -> aux row (col + 1) acc (* Skip None cells *))
  in
  aux 0 0 [] |> List.rev
;;

let step_gamestate gamestate =
  let player_coords = get_guard_coordinates gamestate in
  let rec loop gamestate player_coords direction previous_positions =
    let block_in_front =
      get_block_by_coordinates
        gamestate
        (add_coords player_coords (direction_to_movement direction))
    in
    match block_in_front with
    | None -> CoordinateSet.add player_coords previous_positions
    | Some block ->
      (match block with
       | Empty | Guard ->
         loop
           gamestate
           (add_coords player_coords (direction_to_movement direction))
           direction
           (CoordinateSet.add player_coords previous_positions)
       | Obstruction ->
         loop
           gamestate
           player_coords
           (rotate direction)
           (CoordinateSet.add player_coords previous_positions))
  in
  loop gamestate player_coords Up CoordinateSet.empty
;;

let step_gamestate_p2 gamestate =
  let player_coords = get_guard_coordinates gamestate in
  let rec loop gamestate player_coords direction seen_obstructions =
    let block_in_front =
      get_block_by_coordinates
        gamestate
        (add_coords player_coords (direction_to_movement direction))
    in
    let obstructionCoordWithDirection =
      { coord = { x = player_coords.x; y = player_coords.y }; direction }
    in
    match
      CoordinateWithDirectionSet.mem
        obstructionCoordWithDirection
        seen_obstructions
    with
    | true -> true
    | false ->
      (match block_in_front with
       | None -> false
       | Some block ->
         (match block with
          | Empty | Guard ->
            loop
              gamestate
              (add_coords player_coords (direction_to_movement direction))
              direction
              (CoordinateWithDirectionSet.add
                 obstructionCoordWithDirection
                 seen_obstructions)
          | Obstruction ->
            loop
              gamestate
              player_coords
              (rotate direction)
              (CoordinateWithDirectionSet.add
                 obstructionCoordWithDirection
                 seen_obstructions)))
  in
  loop gamestate player_coords Up CoordinateWithDirectionSet.empty
;;

let () =
  let gamestate = read_gamestate "inputs/day06.txt" in
  match gamestate with
  | None -> raise (Invalid_argument "BAD GAMESTATE")
  | Some state ->
    let modified_gamestates = generate_all_modifications state in
    let () =
      Printf.printf "modified states %d\n" (List.length modified_gamestates)
    in
    let infinite_loops =
      List.fold_left
        (fun acc state -> if step_gamestate_p2 state then acc + 1 else acc)
        0
        modified_gamestates
    in
    let () = Printf.printf "Part 2: %d\n " infinite_loops in
    (match gamestate with
     | None -> raise (Invalid_argument "BAD GAMESTATE")
     | Some state ->
       print_int (List.length (CoordinateSet.elements (step_gamestate state))))
;;
