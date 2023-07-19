type 'a par = 'a Bsmlmpi.par

let bsp_p = Z.of_int Bsmlmpi.bsp_p

let zify (f: int -> 'a) : Z.t -> 'a = 
  fun z ->f(Z.to_int z)

let intify (f: Z.t -> 'a) : int -> 'a =
  fun i -> f(Z.of_int i)

let mkpar (f: Z.t->'a) : 'a par = 
  Bsmlmpi.mkpar (intify f)

let apply (vf:('a->'b)par) (vv: 'a par) : 'b par = 
  Bsmlmpi.apply vf vv 

let proj (v: 'a par) : Z.t -> 'a = 
  let f = Bsmlmpi.proj v in 
  zify f
  
let put (tosend: (Z.t->'a) par) : (Z.t->'a) par = 
  let replicate x = Bsmlmpi.mkpar(fun _ -> x) in
  let parfun f v = apply(replicate f) v in 
  parfun zify (Bsmlmpi.put (parfun intify tosend))
