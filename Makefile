SHELL:=/bin/bash
UNAME_M := $(shell uname -m)
FC = gfortran
FFLAGS = -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall

ifeq ($(UNAME_M),x86_64)
    FFLAGS += -mcmodel=medium
endif

all:
	$(FC) $(FFLAGS) -o synspec51_fork synspec51_fork.f90
