# colabfold-protocol

## Execution
```sh
cd batch
# Predict the structure of GPI complex with alphafold_multimer_v3
sh run_colabfold_GPIT_complex.sh
# Predict complex structure pairwisely
sh run_colabfold_GPIT_pair.sh
# Run colabfold for each monomer
sh run_colabfold_GPIT_monomer.sh
# Validate the predicted structure by aligning to the experimental structure
sh validate_colabfold_prediction.sh
```