let _ = 
  Cli.run_homomorphism 
    (fun z -> z)
    Mps__MPS.mps_par
    (fun value -> print_int (Z.to_int value))