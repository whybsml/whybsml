let _ = Random.self_init ()

type matrix = int array array 

let gen_matrix (size: int): matrix = 
  let mat = Array.make_matrix size size 0 in
  let set () = 
    let column = Random.int size 
    and row = Random.int size in
    mat.(column).(row) <- 1 in
  for i = 0 to Random.int size do 
    set ();
  done;
  mat 

let is_square (m: matrix): bool =
  let dim = Array.length m in 
  Array.for_all (fun row->(Array.length row)=dim) m

let dim(m: matrix): int = 
  assert(is_square m);
  Array.length m

let ( *! ) (m1: matrix) (m2: matrix): matrix =
  assert(is_square m1 && is_square m2 && dim m1 = dim m2);
  let n = (dim m1) in 
  let m = Array.make_matrix n n 0 in 
  for i = 0 to n - 1 do 
    for j = 0 to n - 1 do 
      for k = 0 to n - 1 do 
        m.(i).(j) <- m.(i).(j) + m1.(i).(k) * m2.(k).(j)
      done;
    done;
  done;
  m
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
    (fun _ ->gen_matrix 50)
    (Count__Count.count_par (fun m-> (m *! m) |> is_diagonal))
    Cli.print_Z