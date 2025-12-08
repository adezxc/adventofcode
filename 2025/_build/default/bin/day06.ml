let input = Aoc.read_lines "inputs/day06.txt"


let string_to_op input =
  match input with
  | "*" -> ( * )
  | "+" -> (+)
  | _ -> failwith "unknown operation"

let parse_symbols line =
  let symbols = Str.split (Str.regexp "[ \t]+") line in
  List.map (string_to_op) symbols

let parse_line line =
  let nums_str = Str.split (Str.regexp "[ \t]+") line in
  List.map (int_of_string) nums_str

let parse_input input =
  let rec aux lines num_lists =
  match lines with
    | [x] -> (num_lists, parse_symbols x)
    | x :: xs -> aux xs ((parse_line x) :: num_lists)
    | _ -> failwith "Invalid range format"
  in
  aux input []

let part1 input =
  let (lines, symbols) = (parse_input input) in
  
  match lines with
  | [] -> 0
  | head :: rest ->
    let initial_state = List.combine head symbols in
    let rec aux acc rows =
      match rows with
      | [] ->
        List.fold_left (fun total (num, _op) -> total + num) 0 acc
      | current_row :: remaining_rows ->
        let new_acc = 
          List.map2 (fun (prev_num, op) current_num ->
            (op prev_num current_num, op)
          ) acc current_row
        in
        aux new_acc remaining_rows
    in
    aux initial_state rest

let () = Printf.printf "Part 1 solution: %d\n" (part1 input)
;;

let rec pow base exp =
  if exp < 0 then
    1
  else if exp = 0 then
    1
  else
    base * (pow base (exp - 1))

let parse_line line lengths =
  let is_whitespace c = c = ' ' || c = '\t' in

  let ascii_to_int input =
    Char.code input - Char.code '0' in

  let rec aux2 line max_length length acc =
  if length >= max_length then
    match line with
    | _ :: xs -> (List.rev acc, xs)
    | [] -> (List.rev acc, [])
  else
  match line with
  | x :: xs when is_whitespace x -> aux2 xs max_length (length+1) (0 :: acc) 
  | x :: xs -> aux2 xs max_length (length+1) (ascii_to_int x :: acc) 
  | [] -> (List.rev acc, []) in

  let rec aux line lengths acc =
    match lengths with
    | [] -> List.rev acc
    | x :: xs -> begin
                  let (elem, updated_line) = aux2 line x 0 [] in
                  aux updated_line xs (elem :: acc)
                 end
    in aux line lengths []                    

let print_parsed_line line =
  List.iter
    ( fun elem -> 
      let _ = Printf.printf "\n[" in List.iter (
        fun a -> Printf.printf "%d " a
      ) elem
    ) line

let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) [];;

let calc_lengths symbol_line =
  let strings = Str.split (Str.regexp "[*|+]") symbol_line in
  List.map (String.length) strings 
  
let parse_input_p2 input =
  let lengths = calc_lengths (List.nth input ((List.length input)-1)) in
  let rec parse_lines input acc =
  match input with
  | [x] -> (List.rev acc, (parse_symbols x))
  | x :: xs -> parse_lines xs ((parse_line (explode x) lengths) :: acc)
  | _ -> failwith "unexpected argument" in
  parse_lines input [] 

let calc_row line powers = 
  List.map2 (fun elem power -> List.map2 (fun a b ->(a * (pow 10 (b-1)), a != 0)) elem power) line powers

let rec get_rows_powers lines acc =
  match lines with
  | x :: xs ->  get_rows_powers xs ((List.map (fun elem -> List.map (fun a -> if a = 0 then 0 else 1) elem) x) :: acc) 
  | [] -> List.rev acc

let sub_powers powers isdigit_list =
  List.map2 (fun elem isdigits -> List.map2 (fun elem isdigit -> if elem > 0 && isdigit then elem-1 else elem) elem isdigits) powers isdigit_list

let rec mult_rows lines powers acc = 
    match lines with
    | x :: xs -> begin
                 let row = List.map (List.split) (calc_row x powers) in
                 let digit_list = List.map (fun (a,_) -> a) row in
                 let isdigit_list = List.map (fun (_,b) -> b) row in
                  mult_rows xs (sub_powers powers isdigit_list) (digit_list :: acc) 
                 end

    | [] -> List.rev acc 

let rec add_rows lines =
    match lines with
    | x :: y :: xs -> begin
                      let concat_rows = (List.map2 (
                        fun a b ->
                        List.map2 (+) a b
                      ) x y) in
                      add_rows (concat_rows :: xs)
                      end
    | [x] -> x
    | [] -> failwith "shouldn't be empty"

let part2 =
  let (lines, symbols) = parse_input_p2 input in
  let powers = (add_rows (get_rows_powers lines [])) in
  let multed_lines = mult_rows lines powers [] in
  let added_row = add_rows multed_lines in
  let _ = print_parsed_line added_row in
  let rec aux acc cols ops =
  match cols, ops with
  | [], []-> acc
  | x :: xs, y :: ys -> begin
                        match x with
                        | num :: rest -> aux (acc+(List.fold_left y num rest)) xs ys
                        | _ -> failwith "unexpected"
                        end
  | _ -> failwith "unexpected"
  in aux 0 added_row symbols

let () = Printf.printf "Part 2 solution: %d\n" part2
;;



