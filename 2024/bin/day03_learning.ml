(* Found here: https://topaz.github.io/paste/#XQAAAQBnBgAAAAAAAAAUCoAi1uEj4Wk2RB0vws0Kip8xgktpYUP0m+3yU9NGsjLCdwdoqyqSu+4R2543i23iQRL7PTgN0OEcqLy3hLOTvTsDqm8weoD5TlCJlISeCCfVXe8FmAlN+kwwoXZnCiSCHhUuo2PORjvarwh9admBgqPf6RutbUwNdhxzM5nT6xLCYYratlVdc54ZGKqN0CrR+t6nWC2DLDAPplMIJdBHzUEuGRovI76HJVVrpihpSz1Kv+JzaS8fPgLpyXCgC9rCWqhdEIHB4KTDA8B9D8SOT8obI0UA5Qk8lNOp91gg5bJSJMJsE6Rg/jJUfSLMmS11SeUQC0XmM2+ePyYimpxY+D5Vfxn4ejfKb0fmxzVxqLwBcJjtc7hxEIe69NVn+f7RCR5DtXW/hVQoCnYjzjCQDGiDvobYgzxIxVyD3EUpDKbq6G5vKo1mBlBh2w50VP35wMcwOovpqp7/qdBjmb1F+RCznlOsX5Ba2YNlzI8S/WfEg3E2pqyXOMUFcgJLAMlQuq9Mv4JbxPR92IzDypcIMWYu7FbVac6Mj3SHw3iOunCjFhpT962/volYjvn5qbsEdBEUlbvbBbBGgmnn0NvOs3Ny/aQWA438lfr3raZ2HW6ZQTgCDfShPgDHyfSKn+qY46EyWl26oVc/RorfIkwQdYHGj9aZxtTObVGZGPLYg9fhqvnxddU1y0D0na4fJAP1jaHPMBh6PRoU64umtQ0Lkwv+0ExE5OEmX/HPhLAmtquSaZJGjxXo199yYHOI3kk0pwagez/2V+cy5gZSOLnI+m0ZQQkKVS5ldDQk1b2PZiD6ggqJPgXjx2Io3TaYUcqdrRi9Qgf31laZjO3KrRn30nWJCcGLgFF/ff/KDQ8e, solution purely for learning *)
(* 2024 Day 3 *)

(* Input *)
let read_in path =
  let open In_channel in
  with_open_text path input_all
;;

(* Part 1 *)
let find_muls mem =
  let patt = Str.regexp {|mul(\([0-9]+\),\([0-9]+\))|}
  and group n = Str.matched_group n mem |> int_of_string in
  let rec parse idx pairs =
    try
      let jdx = Str.search_forward patt mem idx
      and pair = group 1, group 2 in
      parse (Int.succ jdx) (List.cons pair pairs)
    with
    | Not_found -> pairs
  in
  parse 0 []
;;

let sum_muls mem =
  find_muls mem |> List.fold_left (fun sum (x, y) -> sum + (x * y)) 0
;;

let fst_solve path = read_in path |> sum_muls

(* XXXXXXXXX *)

(* Part 2 *)
type statement =
  | Enabled
  | Disabled
  | Mul of int * int

let parse_stmt mem = function
  | "do()" -> Enabled
  | "don't()" -> Disabled
  | _pair ->
    let group n = Str.matched_group n mem |> int_of_string in
    Mul (group 1, group 2)
;;

let find_muls_with_cond mem =
  let patt = Str.regexp {|mul(\([0-9]+\),\([0-9]+\))\|do()\|don't()|} in
  let rec parse_mem idx stmts =
    try
      let jdx = Str.search_forward patt mem idx
      and stmt = Str.matched_string mem |> parse_stmt mem in
      parse_mem (Int.succ jdx) (List.cons stmt stmts)
    with
    | Not_found -> List.rev stmts
  in
  parse_mem 0 []
;;

let sum_muls_with_cond mem =
  find_muls_with_cond mem
  |> List.fold_left
       (fun ((mode, sum) as dat) stmt ->
         match stmt with
         | Enabled -> Enabled, sum
         | Disabled -> Disabled, sum
         | Mul (x, y) -> if mode = Enabled then mode, sum + (x * y) else dat)
       (Enabled, 0)
;;

let snd_solve path = read_in path |> sum_muls_with_cond |> snd

(* XXXXXXXX *)
