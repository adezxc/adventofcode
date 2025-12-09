let input = Aoc.read_lines "inputs/day07.txt"

let part1 input =
  let find_char string symbol =
    let rec aux char_list symbol acc index =
    match char_list with
    | [] -> List.rev acc 
    | x :: xs when (x = symbol) -> aux xs symbol (index :: acc) (index+1) 
    | _ :: xs -> aux xs symbol acc (index+1)  
    in aux (Aoc.explode string) symbol [] 0 in

  let calc_next_state state indices =
    let rec aux2 number indices acc =
      match indices with
      | [] -> ([number], 0)
      | x :: _ when x = number -> ([(x-1); (x+1)], acc+1)
      | _ :: xs -> aux2 number xs acc 
    in
    let rec aux state acc1 acc2 =
    match state with
    | [] -> (acc1, acc2)
    | x :: xs ->
      begin
        let (new_indices, splits) = (aux2 x indices 0) in
        aux xs (List.sort_uniq (compare) (new_indices @ acc1)) (acc2+splits)
      end
    in aux state [] 0 in
    
  match input with
  | [] -> 0
  | head :: rest ->
      begin
        let initial_state = find_char head 'S' in
        let rec aux lines state acc =
        match lines with
        | [] -> acc
        | x :: xs ->
            begin
              let split_indices = find_char x '^' in
              let (state, splits) = calc_next_state state split_indices in
              aux xs state (acc+splits)
            end
        in aux rest initial_state 0
      end

  let () = Printf.printf "Part 1 solution %d\n" (part1 input)
  ;;

                    
