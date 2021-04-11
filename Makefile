all:
	gfortran-6 -fno-automatic -fno-align-commons -ffixed-form -fcheck=mem -O3 -Wall -o synspec51_fork synspec51_fork.f90

cluster:
#	module load gcc/6.5.0
	gfortran -fno-automatic -fno-align-commons -ffixed-form -g -fcheck=all,no-bounds -O3 -Wall -Wl,--rpath=/software/Ubuntu-20.04/Programming/gcc/6.5.0/lib64 -Wl,--disable-new-dtags -o synspec51_fork synspec51_fork.f90
