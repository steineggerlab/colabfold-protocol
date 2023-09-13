# File: run_colabfold_GPI_pair.sh
# Project: colabfold-protocol
# Author: Hyunbin Kim (khb7840@gmail.com)

list="Pair01_PIGU_PIGS Pair02_PIGU_PIGT Pair03_PIGU_PIGK Pair04_PIGU_GPAA1 Pair05_PIGS_PIGT Pair06_PIGS_PIGK Pair07_PIGS_GPAA1 Pair08_PIGT_PIGK Pair09_PIGT_GPAA1 Pair10_PIGK_GPAA1"

for PAIRFILE in $list
do
    # Log
    echo "Running colabfold for $PAIRFILE"
    # Make directory
    mkdir -p result/pairs/$PAIRFILE
    # Run colabfold
    colabfold_batch --num-recycle 3 --use-gpu-relax --model-type alphafold2_multimer_v3 data/$PAIRFILE.csv ./result/pairs/$PAIRFILE
done
