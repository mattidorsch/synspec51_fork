SHELL:=/bin/bash
UNAME_M := $(shell uname -m)
FC = gfortran
FFLAGS = -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall

#ifeq ($(UNAME_M),x86_64)
#    FFLAGS += -mcmodel=medium
#endif

LINELIST = data_syn/linelist.dat

all: $(LINELIST)
	$(FC) $(FFLAGS) -o synspec51_fork synspec51_fork.f90

# The line list is kept compressed in the repository, being too large to
# hold there unpacked. Unpack it whenever the archive is the newer of the
# two, or nothing is unpacked yet. It goes through a temporary file, so an
# interrupted run cannot leave a truncated list that looks up to date; the
# name is one .gitignore already covers.
$(LINELIST): $(LINELIST).gz
	gunzip -c $< > data_syn/linelist.tmp.dat
	mv -f data_syn/linelist.tmp.dat $@

linelist: $(LINELIST)

.PHONY: all linelist
