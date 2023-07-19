OCAMLMAKEFILE = ../ocamlmake/OCamlMakefile
CFLAGS= -I$(OCAMLLIBPATH)  -O -g -Wall -fPIC $(shell pkg-config --cflags ompi)
LFLAGS= -warn-error -a $(shell pkg-config --libs ompi)
LIBDIRS= ../bsml ../bsml/lib
INCDIRS= ../bsml ../bsml/lib . $(shell ocamlfind query zarith)
LIBS= bsmlmpi zarith
SOURCES= bsml.mli bsml.ml
RESULT= bsml
all: bcl ncl
-include $(OCAMLMAKEFILE)