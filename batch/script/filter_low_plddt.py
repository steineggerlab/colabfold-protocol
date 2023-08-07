#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File: filter_low_plddt.py
# Description: Filter residues with low pLDDT and return a PDB file with only high pLDDT residues
# Usage: python filter_low_plddt.py <cutoff> <input_pdb> <output_pdb>
# Created: 2023-08-07 15:06:32
# Author: Hyunbin Kim (khb7840@gmail.com)

# BioPython is required
from Bio.PDB.PDBIO import PDBIO, Select
from Bio.PDB import PDBParser
import sys

# Overloading accept_residue to filter out low plddt
class BFactorFilter(Select):
    def __init__(self, cutoff):
        self.cutoff = cutoff
    def accept_residue(self, residue):
        return residue["CA"].get_bfactor() >= self.cutoff

def main():
    verbose = False
    cutoff = float(sys.argv[1])
    input_pdb = sys.argv[2]
    output_pdb = sys.argv[3]

    parser = PDBParser()
    structure = parser.get_structure('input', input_pdb)
    if verbose:
        print(f"Filtering {input_pdb} with cutoff {cutoff}")
    io = PDBIO()
    io.set_structure(structure)
    bffilter = BFactorFilter(cutoff)
    io.save(select=bffilter, file=output_pdb)
    if verbose:
        print(f"Saved to {output_pdb}")

if __name__ == "__main__":
    main()
