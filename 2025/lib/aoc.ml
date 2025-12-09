let read_all file =
  Stdio.In_channel.with_file file ~f:(fun channel ->
    In_channel.input_all channel)
;;

let int_from_bool b = if b then 1 else 0

let read_lines file =
  Stdio.In_channel.with_file file ~f:(fun channel ->
    let x = In_channel.input_all channel in
    Core.String.split_lines x)
;;

let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) [];;

