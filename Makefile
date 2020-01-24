default_target: all

COQFLAGS= -Q ./src/ExfalsoPP ExfalsoPP

DEPFLAGS:=$(COQFLAGS)

COQC=$(COQBIN)coqc
COQTOP=$(COQBIN)coqtop
COQDEP=$(COQBIN)coqdep $(DEPFLAGS)
COQDOC=$(COQBIN)coqdoc

%.vo: %.v
	$(COQC) $(COQFLAGS) $*.v

EXAMPLE_VS:=$(shell find src/ExfalsoPP/Examples -type f -name '*.v')
EXAMPLE_VOS:=$(patsubst %.v,%.vo,$(EXAMPLE_VS))

lib: src/ExfalsoPP/ExfalsoPP.vo

examples: $(EXAMPLE_VOS)

all: lib examples

# . is replaced by _ to make it usable as an identifier
COQ_VERSION:=$(shell coqc -v | sed -E -n -e 's/The Coq Proof Assistant, version ([^ ]+) .*/\1/p' | sed -e 's/\./_/g')

VERSION_FILE:=src/ExfalsoPP/Versions/V_$(COQ_VERSION).v

src/ExfalsoPP/Core.v: $(VERSION_FILE)
	cp $(VERSION_FILE) src/ExfalsoPP/Core.v

.depend depend: src/ExfalsoPP/Core.v
	$(COQDEP) >.depend `find src -name '*.v'`

clean:
	find src -type f \( -name '*.glob' -o -name '*.vo' -o -name '*.aux' \) -delete
	rm .depend
	rm src/ExfalsoPP/Core.v

include .depend
