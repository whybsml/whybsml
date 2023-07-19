OCAMLMAKEFILE = ../ocamlmake/OCamlMakefile
CFLAGS= -O -g -Wall -fPIC $(shell pkg-config --cflags ompi)
LFLAGS= -warn-error -a
LDFLAGS= $(shell pkg-config --libs ompi) 
OCAMLLDFLAGS= -cc mpicc
INCDIRS= lib 
SOURCES= lib/bsmlsig.mli lib/bsmlsig.ml lib/parameters_in_file.ml lib/parallel.ml lib/comm_mpi.c lib/mpi.mli lib/mpi.ml lib/bsmlmpi.mli lib/bsmlmpi.ml
RESULT= bsmlmpi
all: bcl ncl
-include $(OCAMLMAKEFILE)