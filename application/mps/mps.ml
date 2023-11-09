let _ = 
  Cli.run_homomorphism 
    Mps__MPS.mps_par
    (fun value -> print_int (Z.to_int value))