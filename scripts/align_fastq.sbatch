#!/bin/bash

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
##SBATCH --ntasks-per-nodes=4
#SBATCH --cpus-per-task=2
#SBATCH --job-name=fastq_align
##SBATCH --mail-user=aud4002@med.cornell.edu
#SBATCH --mem=40G   # memory requested, units available: K,M,G,T
#SBATCH --error=align_%A_%a.err
#SBATCH --output=align_%A_%a.out

#VARIABLES EXPORTED FROM PARENT SHELL:
#	- ACC_NUM_FILEPATH
#	- OUTDIR

# STAR PARAMS:

spack load star@2.7.0e

THREAD_N=1
STAR_INDEX_PATH="/athena/angsd/scratch/jwh4001/project/hg38_STARindex"

f=$(cat $ACC_NUM_FILEPATH | head -n $SLURM_ARRAY_TASK_ID | tail -1)
f_basename=$(basename $f)    # stripping off filepath
f_name_no_ext=${f_basename%%.*}    # taking off file extensions (".fastq.gz")

echo "file to align: $f"
echo "file new name: ${OUTDIR}${f_name_no_ext}"
echo "JOB ID: $SLURM_ARRAY_TASK_ID"

STAR  --runMode alignReads \
      --runThreadN $THREAD_N \
      --genomeDir $STAR_INDEX_PATH \
      --readFilesIn $f \
      --readFilesCommand zcat \
      --outFileNamePrefix ${OUTDIR}${f_name_no_ext}. \
      --outSAMtype BAM SortedByCoordinate
