open Stdlib__Base
open Sequential__ListTailRecMap

let create (size: int) : Z.t list =
  let rec aux size list =
    if size = 0
    then list
    else aux (size-1) ((Z.of_int((Random.int 100)-(size/2)))::list) in
  aux size []

let to_list (v:'a Bsmlmpi.par) : 'a list =
  let f  = Bsmlmpi.proj v in
  List.map f (List.map Z.to_int procs)

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

let minimum = 
  function 
  | [] -> nan 
  | h::t -> List.fold_left max h t

let printf =
  let null = open_out "/dev/null" in 
  (* Not allowed in safe BSML programming *)
  let is_root = ref true in 
  begin 
    ignore(Bsmlmpi.mkpar(fun i->is_root := i=0));
    if !is_root 
    then Printf.printf
    else Printf.fprintf null
  end

let sync () = 
  ignore(Bsmlmpi.put(Bsmlmpi.mkpar(fun _ _->None)))

let run_homomorphism 
  (make: Z.t->'a)
  (f: 'a list Bsml.par -> 'b)
  (print: 'b -> unit): unit = 
  Random.self_init ();
  let input = 
    Bsml.mkpar(fun _->map' make (create (size()/Bsmlmpi.bsp_p))) in
  begin 
    sync ();
    Bsmlmpi.start_timing();
    let output = f input in
    let _ = Bsmlmpi.stop_timing () in
    let cost = Bsmlmpi.get_cost() in
    let max = cost |> to_list |> maximum in 
    let min = cost |> to_list |> minimum in
    ignore(Bsmlmpi.mkpar(function
      | 0 ->
        begin
	        print_int (Bsmlmpi.bsp_p);
          print_string "\t";
	        print_float max;
          print_string "\t";
          print_float min;
          print_string "\t";
          print output;
          print_newline ();
          flush stdout
        end
      | _ -> ()))
  end

let print_Z z = 
  print_int(Z.to_int z)