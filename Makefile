ifndef CORESTAR_HOME
	CORESTAR_HOME=$(CURDIR)/../corestar
endif
export CORESTAR_HOME

ifndef VFMC_HOME
	VFMC_HOME=$(CURDIR)
endif
export VFMC_HOME

build:
	$(MAKE) -C src

test: build
	$(MAKE) -s -C unit_tests

all: build test

clean:
	rm -f lib/*.a lib/*.cmxa lib/*.cmxs bin/*.cmxs
	$(MAKE) -C src clean
	$(MAKE) -C unit_tests clean

.PHONY: build test test clean

#vim:noet:
