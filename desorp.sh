#!/bin/bash

set -e

_LatestTime_=`foamListTimes -processor -latestTime`

reconstructPar -latestTime
cp 0/src*orig 0/coeff*orig "$_LatestTime_"

pushd "$_LatestTime_"

mv src_coeff_c{.orig,}
mv src_coeff_p{.orig,}
mv coeff_diff_1{.orig,}
mv coeff_diff_2{.orig,}
mv coeff_conv{.orig,}

popd

sed -i -e 's#^endTime#// endTime#' -e 's#^//endTime#endTime#'  system/controlDict
sed -i -e 's#variables "EV=0\..#variables "EV=0.0#' system/funkySetFieldsDict

funkySetFields -latestTime
decomposePar -latestTime -force
