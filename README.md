# colabfold-protocol

## Execution
```sh
cd batch
# Predict the structure of GPI complex with alphafold_multimer_v3
sh script/run_colabfold_GPIT_complex.sh
# Predict complex structure pairwisely
sh script/run_colabfold_GPIT_pair.sh
# Run colabfold for each monomer
sh script/run_colabfold_GPIT_monomer.sh
# Validate the predicted structure by aligning to the experimental structure
sh script/validate_colabfold_prediction.sh
# Render the structure alignment (ChimeraX required)
open script/render_structure_alignment.cxc
```
