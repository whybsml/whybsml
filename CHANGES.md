# Changes

## Version 0.3

### Summary of changes

### Details

- 
## Version 0.2

### Summary of changes

A new skeleton `mapreduce` is provided, and two new applications. A sequential realization of the axiomatization of BSML theory shows there is not any contradiction in the theory. A proof strategy specific to WhyBSML relying only on Alt-Ergo and CVC4 has been added.

### Details

- **bsml.mlw:** the axiomatization has been slightly simplified, in particular the 
  extensionality axiom has been removed. **bsml_realization.mlw** is a simple sequential
  implementation of this theory.
- **stdlib.mlw**: `this` and `procs` are now constants instead of functions taking a
  value of type `unit` as argument.
- **skeletons.mlw**: `mapreduce` is a new skeleton that performs a `map` and a `reduce` is single pass of the input distributed list; the `map` skeleton uses a tail recursive version of sequential `map`
- **mps.mlw**: now uses `mapreduce`
- **average.mlw**, **count.mlw**: two new applications with their associated uncertified code in `application/average` and `application/count`
- **sequential.mlw**: the library of sequential functions has been reorganized, and a few definitions and lemmas have been added
- **config**: contains a parametrized version of WhyBSML strategy and a script to take into account the user's configuration to generate a concrete strategy
- **drivers**: a case for the partial logic function `last` has been added