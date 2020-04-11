#!/bin/bash

while getopts o:f: option
do
case "${option}"
in
o) OUTDIR=${OPTARG};;		# Where to save the output files
f) ACC_NUM_FILEPATH=${OPTARG};;	# Filepath to txt file of fastq.gz filepaths to run on
esac
done

echo "Running alignment of all filepaths in ${ACC_NUM_FILEPATH}"

# Putting a '/' at the end of OUTDIR if it's not there:
if [ "${OUTDIR: -1}" != '/' ]; then
    OUTDIR="${OUTDIR}/"
fi

echo "Output directory: $OUTDIR"

export OUTDIR
export ACC_NUM_FILEPATH


job_array_size=$(cat $ACC_NUM_FILEPATH|wc -l)

echo "Submitting $job_array_size jobs."

sbatch --array=1-$job_array_size /athena/angsd/scratch/bplee/project/final_project/scripts/align_fastq.sbatch

echo "Submitted"
exit
