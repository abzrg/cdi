.PHONY: all cl clp pp dec rec mesh funk reset

all:
	@echo Please refer to README.md

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
dec_ads:
	decomposePar -force

dec_des:
	decomposePar -force -latestTime

# Reconstruct 'em
rec:
	reconstructPar

# Create mesh
mesh:
	blockMesh

# Reset initial values with funkySetFields
funk_ads: reset
	funkySetFields -time 0

funk_des:
	find -name 'src_*orig' -or -name 'coeff_*orig' -printf "%f\n" | while read f; do cp "0/$$f" "$$(foamListTimes -latestTime -withZero)/$${f%.orig}"; done
	funkySetFields -latestTime

# Copy original field values to the respecting fields, for use of funkySetFieldsDict
reset:
	find -name '*.orig' | while read f; do cp $$f ${f%.orig}; done
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
