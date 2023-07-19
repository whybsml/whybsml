OCAMLMAKEFILE = ../ocamlmake/OCamlMakefile
CFLAGS= -I$(OCAMLLIBPATH)  -O -g -Wall -fPIC $(shell pkg-config --cflags ompi)
LFLAGS= -warn-error -a $(shell pkg-config --libs ompi)
INCDIRS= . ../bsml ../bsml/lib ../wrapper $(shell ocamlfind query zarith)
SOURCES= list__List.ml option__Option.ml sequential__Pair.ml sequential__Int.ml sequential__List.ml stdlib__Tool.ml stdlib__Base.ml stdlib__Comm.ml skeletons__Skeletons.ml mps__MPS.ml
RESULT= whybsml
all: bcl ncl
-include $(OCAMLMAKEFILE)