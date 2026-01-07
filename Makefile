SHELL:=/bin/bash

all:
	gfortran -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall -o synspec51_fork synspec51_fork.f90

g6:
	/home/pyxis/mdorsch/local/gcc-6.5.0/bin/gfortran -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall -o synspec51_fork_g6 synspec51_fork.f90

g7:
	gfortran-7 -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall -o synspec51_fork_g7 synspec51_fork.f90
