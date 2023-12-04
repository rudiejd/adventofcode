(* wooooo ocaml lets go *)
open Core

let is_digit = function '0' .. '9' -> true | _ -> false

let str_digits =
    [ "one", "1";
     "two", "2";
     "three",  "3";
     "four", "4";
     "five", "5";
     "six",  "6";
     "seven", "7";
     "eight", "8";
     "nine", "9";
     "1", "1";
     "2", "2";
     "3",  "3";
     "4", "4";
     "5", "5";
     "6",  "6";
     "7", "7";
     "8", "8";
     "9", "9" ]

let rec find_first_number lst =
  match lst with
  | [] -> ' '
  | h :: t -> if is_digit h then h else find_first_number t

let explode_string s = List.init (String.length s) ~f:(String.get s) 

let reverse_explode_string s =
  let len = String.length s in
  List.init len ~f:(fun n -> String.get s (len - n - 1))

let string_of_char c = String.make 1 c

(* add first and last numbers in a string to get calibration value *)
let add_first_and_last_numbers (line : string) =
  if String.length line = 0 then 0
  else
    let first_number = find_first_number (explode_string line) in
    let last_number = find_first_number (reverse_explode_string line) in
    int_of_string (string_of_char first_number ^ string_of_char last_number)

let rec sum l = match l with [] -> 0 | h :: t -> h + sum t

let () =
  let num_list =
    List.map ~f:add_first_and_last_numbers (Jolly.read_lines "day1.txt")

  (* replace all number strings with numbers *)


  in
  let sum = sum num_list in
  Core.printf "%d\n" sum
