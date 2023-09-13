# Validate colabfold prediction of GPIT complex by aligning to the experimental structure
# Required: TMalign, MMalign

ref_pdb=ref/7w72.pdb

monomer_list="PIGU PIGS PIGT PIGK GPAA1"
complex_input=data/GPITcomplex.csv
complex_pred_pdb=result/rank1/GPITcomplex.pdb
log_file=result/colabfold_protocol_TMalign_log.tsv
plddt_cutoff=50
complex_filtered_pdb=result/rank1/GPITcomplex_plddt$plddt_cutoff.pdb

for monomer in $monomer_list
do
    # Log
    echo "Running TMalign for $monomer"
    # Run TMalign and append result to log file
    ./TMalign -outfmt 2 -ter 0 -split 2 $ref_pdb result/rank1/$monomer.pdb >> $log_file
done

# Run MMalign for GPIT complex and append result to log file
echo "Running MMalign for GPIT complex"
./MMalign -outfmt 2 -full T $ref_pdb $complex_pred_pdb >> $log_file

# Filter GPIT complex with pLDDT > 50 & Run MMalign
echo "Filtering GPIT complex PDB with pLDDT > $plddt_cutoff"
python script/filter_low_plddt.py $plddt_cutoff $complex_pred_pdb $complex_filtered_pdb
echo "Running MMalign for GPIT complex with pLDDT > $plddt_cutoff"
./MMalign -outfmt 2 -full T $ref_pdb $complex_filtered_pdb >> $log_file

echo "Done"