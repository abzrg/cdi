.PHONY: all cl clp dec rec mesh funk reset help

all: cl clp reset mesh funk dec

help:
	@echo "./Allrun && ./desorp.sh && ./Allrun"

# Clean decompoesed times (clean in parallel)
clp:
	-foamListTimes -processor -rm

# Clean reconstructed times (clean in single)
cl:
	-foamListTimes -rm

# Decompose 'em
dec:
	decomposePar -force

# Reconstruct the latest time
rec:
	reconstructPar -latestTime

# Create mesh
mesh:
	blockMesh

# Reset initial values with funkySetFields
funk: reset
	funkySetFields -time 0

# Copy original field values to the respecting fields, for use of funkySetFieldsDict
reset:
	cp 0/U.orig 0/U
	cp 0/p.orig 0/p
	cp 0/src_coeff_p.orig 0/src_coeff_p
	cp 0/src_coeff_c.orig 0/src_coeff_c
	cp 0/coeff_diff_1.orig 0/coeff_diff_1
	cp 0/coeff_diff_2.orig 0/coeff_diff_2
	cp 0/coeff_conv.orig 0/coeff_conv
	rm -rf postProcessing

monitor:
	foamMonitor -r 1 -yrange "[0:30]" -t "Avg Concentration in outlet" postProcessing/patchAverage/0/surfaceFieldValue.dat
