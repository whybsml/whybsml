(** * A wrapper around Bsmlmpi for using Z.t as the type for processor identifiers. *)

type 'a par 
val bsp_p : Z.t
val mkpar : (Z.t -> 'a) -> 'a par
val apply : ('a -> 'b) par -> 'a par -> 'b par
val proj : 'a par -> Z.t -> 'a
val put : (Z.t -> 'a) par -> (Z.t -> 'a) par
