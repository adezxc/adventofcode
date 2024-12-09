let lines = Aoc.read_lines "inputs/day07.txt"

let get_sum_and_products line =
  let rec get_products products =
    match products with
    | [] -> []
    | head :: tail ->
      if head == "" || head = "\n"
      then get_products tail
      else int_of_string head :: get_products tail
  in
  match String.split_on_char ':' line with
  | [] -> 0, []
  | [ sum; rest ] ->
    let filtered_rest =
      String.split_on_char ' ' rest |> List.filter (( <> ) "")
    in
    int_of_string sum, get_products filtered_rest
  | _ :: _ -> raise (Invalid_argument "wtf2")
;;

let print_sum_and_products (sum, prods) =
  Printf.printf "%d: " sum;
  List.iter (fun prod -> Printf.printf "%d " prod) prods;
  print_endline ""
;;

let multiply_list list = List.fold_left (fun acc item -> acc * item) 1 list

let concat a b =
  int_of_string (String.concat "" [ string_of_int b; string_of_int a ])
;;

let branch a b = [ a * b; a + b ]

let branch_p2 a b =
  let result = [ a * b; a + b; concat a b ] in
  result
;;

let find_solution sum products branch_rule =
  let rec branch_out branches products =
    match products with
    | [] -> branches
    | first :: tail ->
      let branches =
        List.map (fun b -> branch_rule first b) branches |> List.flatten
      in
      branch_out branches tail
  in
  match products with
  | [] -> 0
  | first :: second :: rest ->
    let branches = branch_out (branch_rule second first) rest in
    (match List.find_opt (fun x -> x == sum) branches with
     | None -> 0
     | Some x -> x)
  | _ -> raise (Invalid_argument "AAAAA")
;;

let () =
  let sums, products =
    List.map (fun line -> get_sum_and_products line) lines |> List.split
  in
  Printf.printf
    "Part 1: %d\n"
    (List.fold_left2
       (fun acc a b -> acc + find_solution a b branch)
       0
       sums
       products);
  Printf.printf
    "Part 2: %d\n"
    (List.fold_left2
       (fun acc a b -> acc + find_solution a b branch_p2)
       0
       sums
       products)
;;
