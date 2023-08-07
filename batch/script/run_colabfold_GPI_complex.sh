# File: run_colabfold_GPI_complex.sh
# Project: colabfold-protocol
# Author: Hyunbin Kim (khb7840@gmail.com)

echo "Running colabfold for GPI complex"
# Make directory
mkdir -p result/complex
# Run colabfold
colabfold_batch --num-recycle 3 --use-gpu-relax --model-type alphafold2_multimer_v3 data/GPIcomplex.csv ./result/complex
