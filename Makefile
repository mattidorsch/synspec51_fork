all:
	gfortran-6 -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall -o synspec51_fork synspec51_fork.f90
