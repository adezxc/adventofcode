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

let string_to_char_list s = s |> String.to_seq |> List.of_seq
