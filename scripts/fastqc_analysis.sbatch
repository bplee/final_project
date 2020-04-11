#!/bin/bash

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
##SBATCH --ntasks-per-nodes=4
#SBATCH --cpus-per-task=2
#SBATCH --job-name=fastqc
#SBATCH --mem=8G   # memory requested, units available: K,M,G,T
#SBATCH --error=fastqc_%A_%a.err
#SBATCH --output=fastqc_%A_%a.out

#VARIABLES EXPORTED FROM PARENT SHELL:
#	- ACC_NUM_FILEPATH
#	- OUTDIR

# STAR PARAMS:

spack load fastqc


f=$(cat $ACC_NUM_FILEPATH | head -n $SLURM_ARRAY_TASK_ID | tail -1)
#f_basename=$(basename $f)    # stripping off filepath
#f_name_no_ext=${f_basename%%.*}    # taking off file extensions (".fastq.gz")

echo "Running FASTQC ON FILE: $f"
echo "Job array ID: $SLURM_ARRAY_TASK_ID"
fastqc -o $OUTDIR $f
