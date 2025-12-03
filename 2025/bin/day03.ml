let input = Aoc.read_lines "inputs/day03.txt"

let rec pow base exp =
  if exp < 0 then
    raise (Invalid_argument "cannot be negative")
  else if exp = 0 then
    1
  else
    base * (pow base (exp - 1))

let get_num_from_char char =
  Char.code(char) - Char.code('0')

let find_highest_joltage bank count =
  let length = String.length bank in
  let rec find_bigger len i max =
    if i >= (len) then
      max
    else
      match (String.get bank i) with
      | '9' -> i
      | comp when Char.compare comp (String.get bank max) > 0 -> find_bigger len (i+1) i
      | _ -> find_bigger len (i+1) max
    in
  let first = find_bigger (length-(count-1)) 0 0 in
  let calc_sum count idx =
    (pow 10 count) * (get_num_from_char(String.get bank idx)) in
  let rec calc_joltage acc i count =
    if count = 0 then
      acc
    else
      let result = find_bigger (length-(count-1)) (i+1) (i+1) in
      calc_joltage (acc + calc_sum (count-1) result) (result) (count-1) 
      in
    calc_joltage (calc_sum (count-1) first) first (count-1)
     
let part1 =
  List.fold_left (fun acc bank -> acc + (find_highest_joltage bank 2)) 0 input

let () = Printf.printf "Part 1 solution: %d\n" part1
;;
  
let part2 =
  List.fold_left (fun acc bank -> acc + (find_highest_joltage bank 12)) 0 input

let () = Printf.printf "Part 2 solution: %d\n" part2
;;
