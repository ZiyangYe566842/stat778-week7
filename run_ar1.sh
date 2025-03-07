#!/bin/bash
#SBATCH --job-name=AR1_estimation
#SBATCH --output=AR1_estimation_%j.out
#SBATCH --error=AR1_estimation_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH --time=02:00:00
#SBATCH --partition=bigmem  # bigmem


module load r/3.6.3


Rscript myrscript.R --ncores 1 --repl 100 --task 1

