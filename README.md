# WhyBSML version 0.1

## Authors

- Olivia Proust, Université d'Orléans, France
- Frédéric Loulergue, Université d'Orléans, France

## Requirements

For the verification part:

- Why3 version 1.6.0
- Alt Ergo 2.4.3
- CVC4 version 1.6 or higher
- Z3 version 4.12

For the compilation part:

- [OPAM](https://opam.ocaml.org)
- The conf-mpi [OPAM](https://opam.ocaml.org) package

## Overview

WhyBSML is a formalization of the core module of the [BSML](https://bsml-lang.github.io) library, an OCaml library for scalable parallel computing and a set of verified libraries implemented with this core module.

## Usage

In the root directory:

- `make doc` generates the documentation in `html` it also generates the HTML summary of the verification session in `why3session.html`
- `make replay` replays the verification session
- `make compile` generates the OCaml code from the WhyML development and compiles all the dependencies. In `application`, `mps.byte` and `mps.native` are respectively the bytecode and native code executable application programs.
- `make clean` remove the generated files

### Using the MPS application

`mps.byte` and `mps.native` are executable as they are. They take as argument the size of the randomly generated (distributed) list. If ran directly they run using only one processor. To use several processors, `mpirun` with option `-np` is necessary. For example, `mpirun -np 400 application/mps.native 1_000_000` will run the (native code version of the) application on a list of one million numbers and will use 400 processors to do so (it is very likely that in this case the machine is a cluster of PCs or another kind of distributed memory machine).

## Structure

- `README.md`: this file
- `LICENSE`: the license file
- `bsml.mlw`: the formalization of BSML core
- `sequential.mlw`: a library of sequential functions (mostly on lists)
- `stdlib.mlw`: a verified BSML standard library
- `skeletons.mlw`: verified map and reduce skeletons for parallel programming
- `mps.mlw`: verified sequential and parallel implementations for the maximum prefix sum problem
- `drivers`: Why3 drivers used to extract OCaml code from the `.mlw` files
- `bsml`: a parallel implementation of the BSML code module on top of MPI
- `wrapper`: the BSML core implementation uses OCaml's `int` type while `bsml.mlw` uses WhyML's `int` type which is extracted to the type `Z.t`. This wrapper manages the conversions between these two types
- `extraction`: placeholder for the OCaml code extracted from our WhyML development (contains also a `Makefile`)
- `application`: an executable application that calls the parallel maximum parallel prefix sum function on a randomly generated distributed list
- `ocamlmake`: Ocaml-makefile by Markus Mottl , used for compilation
