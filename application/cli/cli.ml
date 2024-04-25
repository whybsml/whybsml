open Stdlib__Base

let create (size: int) : Z.t list =
  let rec aux size list =
    if size = 0
    then list
    else aux (size-1) ((Z.of_int((Random.int size)-(size/2)))::list) in
  aux size []

let to_list (v:'a Bsmlmpi.par) : 'a list =
  let f  = Bsmlmpi.proj v in
  List.map f (List.map Z.to_int (procs()))

let size () =
  try
    int_of_string (Sys.argv.(1))
  with _ ->
    begin
      print_string ("Usage: "^(Sys.argv.(0))^" global_size (multiple of bsp_p)\n");
      exit 1;
    end

let maximum = 
  function 
  | [] -> nan 
  | h::t -> List.fold_left max h t

let run_homomorphism 
  (make: Z.t->'a)
  (f: 'a list Bsml.par -> 'b)
  (print: 'b -> unit): unit = 
  Random.self_init ();
  let input = 
    Bsml.mkpar(fun _->List.map make (create (size()/Bsmlmpi.bsp_p))) in
  let _ = Bsmlmpi.start_timing() in
  let output = f input in
  let _ = Bsmlmpi.stop_timing () in
  let cost = Bsmlmpi.get_cost() |> to_list |> maximum in 
  ignore(Bsmlmpi.mkpar(function
      | 0 ->
        begin
	        print_int (Bsmlmpi.bsp_p);
          print_string "\t";
	        print_float cost;
          print_string "\t";
          print output;
          print_newline ();
          flush stdout
        end
      | _ -> ()))

let print_Z z = 
  print_int(Z.to_int z)