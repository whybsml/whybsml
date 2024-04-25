let _ = Random.self_init ()

let gen_matrix size = 
  let mat = Array.make_matrix size size 0 in 
  let column = Random.int size 
  and row = Random.int size in
  mat.(column).(row) <- 1;
  mat 

let is_diagonal mat = 
  let dim = Array.length mat in 
  assert(Array.for_all (fun row->(Array.length row)=dim) mat);
  let is_diagonal = ref true in
  for column = 0 to dim - 1 do 
    for row = 0 to dim - 1 do 
      if mat.(column).(row) <> 0 && row <> column
      then is_diagonal := false 
    done;
  done;
  !is_diagonal

let _ = 
  Cli.run_homomorphism 
    (fun _ ->gen_matrix 100)
    (Count__Count.count_par is_diagonal)
    Cli.print_Z