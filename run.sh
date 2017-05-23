#!/bin/bash

# INPUT
# $1 path to initial paramaters set list [p_in]
# $2 path to output observation list [y_out]

# Set default parallel numbers
if [ -z "$3" ]
then
    parallel=4
else
    parallel=$3
fi
rm p_* y_*

# split input file
split -l13 $1 p_
NPROC=0
for i in $(ls p_*)
do
    ./plante.py --parameters-file $i --control-file ../donneesEnvironnement.txt --output-file ./y_$i > /dev/null
    NPROC=$(($NPROC+1))
    if [ "$NPROC" -ge $parallel ]
    then
	wait
	NPROC=0
    fi
done
wait

cat y_* > $2
