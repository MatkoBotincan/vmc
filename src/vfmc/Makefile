ifndef OCAMLMAKEFILE
	export OCAMLMAKEFILE = OcamlMakefile
endif
ifndef OCAMLYACC
	export OCAMLYACC = ocamlyacc -v
endif
ifndef OCAMLC
	export OCAMLC = ocamlc.opt -annot -g
endif 
ifndef OCAMLOPT
	export OCAMLOPT = ocamlopt.opt -annot -g
endif 
ifndef OCAMLDEP
	export OCAMLDEP = ocamldep.opt
endif 
ifndef OCAMLDOC
	export OCAMLDOC = ocamldoc.opt
endif 

ifndef BIN
	BIN := ../../bin
endif
export BIN

ifndef LIB
	LIB := ../../lib
endif
export LIB


INCLUDES = 

VFCFRONT_SOURCES = vfcAST.ml vfcparse.mly vfclex.mll vfclogic.ml vfc2core.ml vfcfront.ml

DEFAULT_ARGS = SOURCES="$(VFCFRONT_SOURCES)" \
       LIBS="str unix dynlink utils prover_syntax symbexe_syntax jimple_syntax plugin_interface prover symbexe parsing" \
       OCAMLLDFLAGS="-I $(LIB) -I $(CORESTAR_HOME)/lib" \
       INCDIRS="$(CORESTAR_HOME)/src/prover $(CORESTAR_HOME)/src/prover_syntax $(CORESTAR_HOME)/src/symbexe_syntax $(CORESTAR_HOME)/src/utils $(CORESTAR_HOME)/src/symbexe $(CORESTAR_HOME)/src/plugin_interface" \
       OCAMLFLAGS="" \
       TRASH=""

MAIN = $(DEFAULT_ARGS) RESULT=$(BIN)/vfmc.byte

MAINOPT = $(DEFAULT_ARGS)  RESULT=$(BIN)/vfmc

default: vfmc

.PHONY: debug
debug: vfmc.byte

all: vfmc vfmc.byte


prebuild: 


.PHONY: vfmc.byte  
vfmc.byte: prebuild
	@$(MAKE) -f $(OCAMLMAKEFILE) $(MAIN) 


.PHONY: vfmc
vfmc: prebuild
	@$(MAKE) -f $(OCAMLMAKEFILE) $(MAINOPT) native-code

clean:
	$(MAKE) -f $(OCAMLMAKEFILE) $(MAIN) clean
	$(MAKE) -f $(OCAMLMAKEFILE) $(MAINOPT) clean
	rm -f *.annot *.cmi *.cmx *.o vfcparse.ml vfclex.ml vfcparse.mli vfclex.mli .depend

.depend:
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml > .depend

dummy:

include .depend
