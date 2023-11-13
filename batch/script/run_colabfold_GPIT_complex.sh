# File: run_colabfold_GPIT_complex.sh
# Project: colabfold-protocol
# Author: Hyunbin Kim (khb7840@gmail.com)

echo "Running colabfold for GPIT complex"
# Make directory
mkdir -p batch/result/complex
# Run colabfold
colabfold_batch --num-recycle 3 --use-gpu-relax --model-type alphafold2_multimer_v3 query/GPITcomplex.csv batch/result/complex
