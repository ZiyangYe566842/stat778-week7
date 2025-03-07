#!/bin/bash
#SBATCH --job-name=AR1_array
#SBATCH --output=AR1_array_%A_%a.out
#SBATCH --error=AR1_array_%A_%a.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH --time=02:00:00
#SBATCH --array=1-10
#SBATCH --partition=bigmem

module load r/3.6.3


Rscript myrscript.R --ncores 1 --repl 100 --task ${SLURM_ARRAY_TASK_ID}
