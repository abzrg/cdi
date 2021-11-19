.PHONY: all cl clp pp dec rec mesh funk reset

all:
	@echo "Run: mpirun -np 4 cdiFoam -parallel >log 2>&1"
	@echo "or: ./Allrun 2>&1 | tee log"

# Single post-processing
spp:
	postProcess -func 'patchAverage(name=outlet,c)'

# Parallel post-processing
ppp:
	mpirun -np 4 postProcess -func 'patchAverage(name=outlet,c)' -parallel

# Clean decompoesed times (clean in parallel)
clp:
	-foamListTimes -processor -rm

# Clean reconstructed times (clean in single)
cl:
	-foamListTimes -rm

# Decompose 'em
dec:
	decomposePar -force

# Reconstruct 'em
rec:
	reconstructPar

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

# Adsorptin voltage
#	  Note: to escape $ in a makefile you prepend it with another $: $$
#			-- source: https://stackoverflow.com/a/3141015/13041067
#	  Note: to send error code if sed failed to find the pattern
#			-- source: https://stackoverflow.com/a/15966279/13041067
# av:
# 	-@sed -i.bak '/EV=-0.5/{s/EV=-0.5/EV=0.5/;h}; $${x;/./{x;q0};x;q1}' \
# 		system/funkySetFieldsDict \
# 		&& echo "Voltage is set to +0.5" \
# 		|| echo "State is already: adsorption!"
# 	-@cat system/funkySetFieldsDict | grep 'EV=0.5' --color=always

# # Desorptin voltage
# dv:
# 	-@sed -i.bak '/EV=0.5/{s/EV=0.5/EV=-0.5/;h}; $${x;/./{x;q0};x;q1}' \
# 		system/funkySetFieldsDict \
# 		&& echo "Voltage is set to -0.5" \
# 		|| echo "State is already: desorption!"
# 	-@cat system/funkySetFieldsDict | grep 'EV=-0.5' --color=always

# Adsorption
#	  source: https://stackoverflow.com/a/11704021/13041067
av:
	-sed -i.bak -e '/adsorption/,+7 s#^//##' system/funkySetFieldsDict
	-sed -i.bak -e '/desorption/,+7 s#^#//#' system/funkySetFieldsDict

dv:
	-sed -i.bak -e '/desorption/,+7 s#^//##' system/funkySetFieldsDict
	-sed -i.bak -e '/adsorption/,+7 s#^#//#' system/funkySetFieldsDict

monitor:
	foamMonitor -r 1 -yrange "[0:30]" -t "Avg Concentration in outlet" postProcessing/patchAverage/0/surfaceFieldValue.dat
