# File: run_colabfold_GPI_monomer.sh
# Project: colabfold-protocol
# Author: Hyunbin Kim (khb7840@gmail.com)

list="PIGU PIGS PIGT PIGK GPAA1"

for FASTA in $list
do
    # Log
    echo "Running colabfold for $FASTA"
    # Make directory
    mkdir -p result/monomer/$FASTA
    # Run colabfold with default model
    colabfold_batch --num-recycle 3 --use-gpu-relax data/$FASTA.fasta result/monomer/$FASTA
done