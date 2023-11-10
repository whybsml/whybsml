OCAMLMAKEFILE = ../../ocamlmake/OCamlMakefile
CFLAGS= -I$(OCAMLLIBPATH)  -O -g -Wall -fPIC $(shell pkg-config --cflags ompi)
LFLAGS= -warn-error -a $(shell pkg-config --libs ompi)
INCDIRS= ../../bsml ../../bsml/lib ../../wrapper $(shell ocamlfind query zarith) ../../extraction
SOURCES= cli.mli cli.ml
RESULT= cli
all: bcl ncl
-include $(OCAMLMAKEFILE)