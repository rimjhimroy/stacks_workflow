#!/bin/bash
#SBATCH -J "rxstacks"
#SBATCH -o log_%j
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=YOUREMAIL
#SBATCH --time=4-00:00
#SBATCH --mem=40000

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

# Error correction
./00-scripts/stacks_5b_rxstacks.sh
