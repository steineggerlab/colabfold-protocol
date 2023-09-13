# File: run_colabfold_GPIT_monomer.sh
# Project: colabfold-protocol
# Author: Hyunbin Kim (khb7840@gmail.com)

list="PIGU PIGS PIGT PIGK GPAA1"

for monomer in $list
do
    # Log
    echo "Running colabfold for $monomer"
    # Make directory
    mkdir -p result/monomer/$monomer
    # Run colabfold with default model
    colabfold_batch --num-recycle 3 --use-gpu-relax data/$monomer.fasta result/monomer/$monomer
done