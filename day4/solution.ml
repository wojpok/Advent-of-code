let read_file filename =
  let file = open_in filename in 
  let rec iter acc =
    try input_line file :: acc |> iter with
    | End_of_file -> acc
  in
  iter []


let parse_line line =
  Scanf.sscanf line "%d-%d,%d-%d" (fun a b c d -> (a, b, c, d))

let part_one lines = 
  let rec iter sum = function
  | [] -> sum
  | x :: xs -> 
    let (a, b, c, d) = parse_line x in
      if (a <= c && d <= b) || (c <= a && b <= d) 
        then iter (sum + 1) xs
        else iter sum xs
  in iter 0 lines 

let () = read_file "data.in" |> part_one |> print_int; print_string "\n"

let part_two lines =
  let rec iter sum = function
  | [] -> sum
  | x :: xs ->
    let (a, b, c, d) = parse_line x in
      if (a <= d && c <= b)
        then iter (sum + 1) xs
        else iter sum xs
  in iter 0 lines

let () = read_file "data.in" |> part_two |> print_int; print_string "\n"