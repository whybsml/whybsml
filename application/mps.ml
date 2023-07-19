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

let size =
  try
    int_of_string (Sys.argv.(1))
  with _ ->
    begin
      print_string ("Usage: "^(Sys.argv.(0))^" global_size (multiple of bsp_p)\n");
      exit 1;
    end

let _ =
  Random.self_init ();
  let input = Bsml.mkpar(fun _->create (size/Bsmlmpi.bsp_p)) in
  let _ = Bsmlmpi.start_timing() in
  let output = Mps__MPS.mps_par input in
  let _ = Bsmlmpi.stop_timing () in
  let cost = (fun (h::t)->List.fold_left max h t) (to_list (Bsmlmpi.get_cost())) in 
  Bsmlmpi.mkpar(function
      | 0 ->
        begin
	        print_int (Bsmlmpi.bsp_p);
          print_string "\t";
	        print_float cost;
          print_string "\t";
          print_int (Z.to_int output);
          print_newline ();
          flush stdout
        end
      | _ -> ())

