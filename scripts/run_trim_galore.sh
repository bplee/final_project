#!/bin/bash

########################################
# Script to run TrimGalore on file/files
########################################

while getopts o:f:r:s: option
do
case "${option}"
in
o) OUTDIR=${OPTARG};;           # Where to save the output files
f) SAMPLE_FILES=${OPTARG};;     # File(s) to run on
esac
done

pwd
ls $SAMPLE_FILES

# Checking for file input
if [ -z "$SAMPLE_FILES" ]; then
    echo "No sample(s) inputted as -f argument to script. Exitting."
    exit
fi

if [ -z "$OUTDIR" ]; then
    echo "No output directory specified for -o argument. Exitting."
    exit
fi

# making sure trim galore is loaded
spack load -r trimgalore

for filepath in $(echo $SAMPLE_FILES):
do
#    filename=$(basename $filepath)
#    output_filename="${OUTDIR}/trimmed_${filename}"
    trim_galore --phred33 -o $OUTDIR $filepath --gzip

done
