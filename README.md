# Easy and accurate protein structure prediction using ColabFold
A step-by-step protocol for predicting protein mono-, multi-mer structures and conformations using ColabFold/AlphaFold2

[Kim G, Lee S, Levy Karin E, Kim H, Moriwaki Y, Ovchinnikov S, Steingger M and Mirdita M. Easy and accurate protein structure prediction using ColabFold. Nature Protocols (2024) doi: 10.1038/s41596-024-01060-5](https://www.nature.com/articles/s41596-024-01060-5)


<p align="center"><img src="https://github.com/steineggerlab/colabfold-protocol/raw/main/.github/ColabFold_Marv_Logo.png" height="250"/></p>

## Overview 
ColabFold has two interfaces: 
1) [Web-based](https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb) jupyter notebooks utilizing Google Colaboratory
2) [Command-line tools](https://github.com/sokrypton/ColabFold) (local)

Our protocol guides readers in three scenarios with both interfaces: (1) monomer prediction, (2) complex prediction, and (3) conformation sampling.

We demonstrate the use of ColabFold with the [human glycosylphosphatidylinositol transamidase (GPIT)](https://www.rcsb.org/structure/7W72) protein for monomer and complex prediction, and the [human Alanine Serine Transporter 2 (ASCT2)](https://www.rcsb.org/structure/6RVX) ([alternative conformation](https://www.rcsb.org/structure/7BCQ)) for conformation sampling.

## Equipment
Protein sequence queries (FASTA/CSV) used in this protocol can be found in the [`/query`](https://github.com/steineggerlab/colabfold-protocol/tree/main/query) directory

- Monomer: [PIGU](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/PIGU.fasta), [PIGT](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/PIGT.fasta), [PIGK](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/PIGK.fasta), [PIGS](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/PIGS.fasta), [GPAA1](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/GPAA1.fasta)
- Multimer: [GPIT complex](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/GPITcomplex.csv),
- Conformation: [ASCT2](https://github.com/steineggerlab/colabfold-protocol/blob/main/query/ASCT2.fasta)

Corresponding experimental structures (PDB) can be found in the [`/ref`](https://github.com/steineggerlab/colabfold-protocol/tree/main/ref) directory
- Monomer, Complex: [GPIT complex](https://github.com/steineggerlab/colabfold-protocol/blob/main/ref/7w72.pdb)
- Conformation: [ASCT2 (inward-open)](https://github.com/steineggerlab/colabfold-protocol/blob/main/ref/6rvx.pdb), [ASCT2 (outward-open)](https://github.com/steineggerlab/colabfold-protocol/blob/main/ref/7bcq.pdb)


## Running web notebooks
To open the notebooks in Google Colaboratory environment, press <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/> button on the top of each notebook.

While most of the notebooks can be executed for free, complex prediction (`GPIT_complex.ipynb`) requires a paid Colab Pro account, due to its long length.

Also, please note that the notebooks are provided as guides for tuning parameters and are not intended for rerunning, considering the potential changes in the Google Colaboratory environment itself. To run the ColabFold-AlphaFold2 notebook from the beginning, navigate [here](https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb). 

- Monomer: [PIGU](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/PIGU.ipynb), [PIGT](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/PIGT.ipynb), [PIGK](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/PIGK.ipynb), [PIGS](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/PIGS.ipynb), [GPAA1](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/GPAA1.ipynb)
- Multimer: [GPIT complex](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/GPIT_complex.ipynb)
- Conformation: [ACST2 (Dropout)](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/ASCT2_conformation_dropout.ipynb), [ACST2 (MSA Depth Reduction)](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/notebook/ASCT2_conformation_MSADepthReduction.ipynb)

The results of the notebooks can be found in the [`/web/result`](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/result) directory. It includes the following output: 
- predicted structures (PDB)
- generated MSAs (A3M) 
- confidence measures (JSON, log.txt): pLDDT, PAE, pTM, ipTM (for complex prediction) 
- images (PNG) for visualizing MSA sequence coverage and confidence measures

## Running locally 
For detailed instructions on how to install ColabFold locally, refer to [ColabFold](https://github.com/sokrypton/ColabFold) or [localcolabfold](https://github.com/YoshitakaMo/localcolabfold).

To run ColabFold locally, one can use this command line:
```sh
colabfold_batch input_seqs.fasta /path/to/results
``` 

To run the procedures in this protocol locally, please follow the steps below. 
```sh
# Clone this repository
git clone https://github.com/steineggerlab/colabfold-protocol.git

# move to the directory
cd colabfold-protocol/batch
# Run colabfold for each monomer
sh script/run_colabfold_GPIT_monomer.sh
# Predict the structure of GPIT complex with alphafold_multimer_v3
sh script/run_colabfold_GPIT_complex.sh
# Predict complex structure pairwisely
sh script/run_colabfold_GPIT_pair.sh
# Validate the predicted structure by aligning to the experimental structure
sh script/validate_colabfold_prediction.sh
# Render the structure alignment (ChimeraX required)
open script/render_structure_alignment.cxc
```
The results of the local predictions can be found in the [`/batch/result`](https://github.com/steineggerlab/colabfold-protocol/blob/main/batch/result) directory, and are organized in the same way as the web notebook output.

## Conformation prediction
This procedure generates multiple conformational states from a single input sequence by increasing the uncertainty of the AlphaFold2 model network. To this end, we use two different strategies: (1) MSA depth reduction and (2) Dropout layers activation.

### Structure prediction 
For each strategy, set ColabFold parameters as follows: 
- MSA depth reduction: `max_msa=32:64`, `num_seeds=16`
- Dropout: `use-dropout`, `num_seeds=16`

With the above setting, a total of 80 structures will be generated for each strategy, and the results will be found in the [`web/result/conformation`](https://github.com/steineggerlab/colabfold-protocol/blob/main/web/result/conformation) and [`batch/result/conformation`](https://github.com/steineggerlab/colabfold-protocol/blob/main/batch/result/conformation) directories for web and local predictions, respectively. Considering its huge size, we only provide 20 representative structures for each strategy.

### Identifying alternative conformations 
This part processes the positions of the amino-acids' alpha carbons under each model with PCA analysis using [CPPTRAJ](https://amberhub.chpc.utah.edu/cpptraj/). Its aim is to reduce the dimensionality from 451 parameters (# processed residues) to only few, which capture most of the conformational movements. One can identify multiple conformational states based on this PCA result, by selecting the representative structures furthest apart from each other along the PC1 and/or PC2 axis (depending on the amount of variance captured by each PC). 

The provided [CPPTRAJ script](https://github.com/steineggerlab/colabfold-protocol/blob/main/batch/script/asct2_pca.in) (run with this [bash script](https://github.com/steineggerlab/colabfold-protocol/blob/main/batch/script/run_cpptraj_asct2.sh)) performs the following steps. This script is largely based on the [script](https://github.com/delalamo/af2_conformations) provided by [del Alamo et al](https://elifesciences.org/articles/75751).
1. Trim off terminal stretches of low-pLDDT scores to reduce noise in the PCA.
2. Compute the average position of the remaining 451 alpha carbons across the 80 protein models and deduct it from each of the models.
3. Compute the covariance matrix of the 451 updated positions.
4. Compute the Eigenvalues and Eigenvectors of the covariance matrix, sort them and rearrange the matrix.
5. Compute the projections of the 80 models along the first three principal components (PCs).

The results of the PCA can be found in [`batch/result/conformation/pca`](https://github.com/steineggerlab/colabfold-protocol/tree/main/batch/result/conformation/pca). Some key outputs are: 
- `project.dat`: The first three PCs for each model (you can ignore the last column (PC3) in this case)
- `%eigenvec.dat`: the amount of variance captured by each PC in descending order (2nd column)

## How do I reference this work?
- Kim G, Lee S, Levy Karin E, Kim H, Moriwaki Y, Ovchinnikov S, Steingger M and Mirdita M. Easy and accurate protein structure prediction using ColabFold. <br />
  Nature Protocols (2024) doi: [10.1038/s41596-024-01060-5](https://www.nature.com/articles/s41596-024-01060-5)

- Mirdita M, Schütze K, Moriwaki Y, Heo L, Ovchinnikov S and Steinegger M. ColabFold: Making protein folding accessible to all. <br />
  Nature Methods (2022) doi: [10.1038/s41592-022-01488-1](https://www.nature.com/articles/s41592-022-01488-1)
- If you’re using **AlphaFold**, please also cite: <br />
  Jumper et al. "Highly accurate protein structure prediction with AlphaFold." <br />
  Nature (2021) doi: [10.1038/s41586-021-03819-2](https://doi.org/10.1038/s41586-021-03819-2)
- If you’re using **AlphaFold-multimer**, please also cite: <br />
  Evans et al. "Protein complex prediction with AlphaFold-Multimer." <br />
  biorxiv (2021) doi: [10.1101/2021.10.04.463034v1](https://www.biorxiv.org/content/10.1101/2021.10.04.463034v1)
- If you are using **RoseTTAFold**, please also cite: <br />
  Baek et al. "Accurate prediction of protein structures and interactions using a three-track neural network." <br />
  Science (2021) doi: [10.1126/science.abj8754](https://doi.org/10.1126/science.abj8754)

