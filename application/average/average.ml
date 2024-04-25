let float_of_Z z = 
  z |> Z.to_int |> float

let div z z' = 
  (float_of_Z z) /. (float_of_Z z')

let _ = 
  Cli.run_homomorphism 
    (fun z -> z)
    Average__Average.avg_par
    (fun (z, z')->div z z' |> print_float)