OCAMLMAKEFILE = ../../ocamlmake/OCamlMakefile
CFLAGS= -O -g -Wall -fPIC $(shell pkg-config --cflags ompi)
LFLAGS= -warn-error -a
LDFLAGS= $(shell pkg-config --libs ompi) 
OCAMLLDFLAGS= -cc mpicc
INCDIRS= ../../bsml ../../bsml/lib ../../wrapper $(shell ocamlfind query zarith) ../../extraction ../cli
LIBS= bsmlmpi zarith bsml whybsml cli
SOURCES= count.ml 
RESULT= count
NCSUFFIX=.native
BCSUFFIX=.byte
NO_CUSTOM=true
all: bc nc
-include $(OCAMLMAKEFILE)