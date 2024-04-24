# WhyBSML version 0.2

## Authors

- Frédéric Loulergue, Université d'Orléans, France
- Olivia Proust, Université d'Orléans, France

## Requirements

For the verification part:

- Why3 version 1.7.1
- Alt Ergo 2.5.2 or higher
- CVC4 version 1.8 or higher

For the compilation part:

- [OPAM](https://opam.ocaml.org)
- The conf-mpi [OPAM](https://opam.ocaml.org) package
- An MPI library such as [OpenMPI](https://www.open-mpi.org) or [MPICH](https://www.mpich.org)

## Overview

WhyBSML is a formalization of the core module of the [BSML](https://bsml-lang.github.io) library, an OCaml library for scalable parallel computing and a set of verified libraries implemented with this core module.

## Usage

In the root directory:

- `make config` generates a WhyBSML proof strategy that is then
available in WhyIDE
- `make ide` launches Why3 IDE
- `make doc` generates the documentation in `html` it also generates the HTML summary of the verification session in `why3session.html`
- `make bench` replays the verification session
- `make compile` generates the OCaml code from the WhyML development and compiles all the dependencies
- `make clean` performs all of the following: 
    - `make clean_config` removes the configured strategy
    - `make clean_session` removes the session directory
    - `make clean_doc` removes the generated documentation
    - `make clean_extraction` removes the generated OCaml source code and compile code

### Using the applications

#### The *MPS* application

In `application/mps`, `mps.byte` and `mps.native` are executable as they are. They compute the maximum prefix sum of a distributed list of integers. They take as argument the size of the randomly generated (distributed) list. If ran directly they run using only one processor. To use several processors, `mpirun` with option `-np` is necessary. For example, `mpirun -np 400 application/mps.native 1_000_000` runs the (native code version of the) application on a list of one million numbers and will use 400 processors to do so (it is very likely that in this case the machine is a cluster of PCs or another kind of distributed memory machine). 

#### The *Average* application

In `application/average`, `average.byte` and `average.native` are respectively the executable byte-code and native code versions of a program that computes the average of a distributed list of integers. Their usage is the same as the *MPS* applications.

## Structure

- `README.md`: this file
- `LICENSE`: the license file
- `bsml.mlw`: the formalization of BSML core
- `sequential.mlw`: a library of sequential functions (mostly on lists)
- `stdlib.mlw`: a verified BSML standard library
- `skeletons.mlw`: verified map and reduce skeletons for parallel programming
- `average.mlw`: verified parallel implementation for the computation of the average of a distributed list of integers
- `count.mlw`: verified parallel implementation of a function counting the number of elements of a distributed list verifying a given predicate
- `mps.mlw`: verified sequential and parallel implementations for the maximum prefix sum problem
- `drivers`: Why3 drivers used to extract OCaml code from the `.mlw` files
- `bsml`: a parallel implementation of the BSML code module on top of MPI
- `wrapper`: the BSML core implementation uses OCaml's `int` type while `bsml.mlw` uses WhyML's `int` type which is extracted to the type `Z.t`. This wrapper manages the conversions between these two types
- `extraction`: placeholder for the OCaml code extracted from our WhyML development (contains also a `Makefile`)
- `application/mps`: an executable application that calls the parallel maximum parallel prefix sum function on a randomly generated distributed list
- `application/average`: an executable application that calls the parallel average function on a randomly generated distributed list
- `ocamlmake`: Ocaml-makefile by Markus Mottl, used for compilation
