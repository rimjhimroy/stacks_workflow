#!/bin/bash
# Removing adapters using cutadapt
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
NCPU=$1

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="10-log_files"

cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

# Test if user specified a number of CPUs
if [[ -z "$NCPU" ]]
then
    NCPU=1
fi

# Create directory for untrimmed files
mkdir 02-raw/trimmed 2>/dev/null

rm 10-log_files/"$TIMESTAMP"_01_cutadapt"${i%.fastq.gz}".log 2> /dev/null
ls -1 02-raw/*.R1.fastq.gz | sed 's/.R1.fastq.gz//g' |
parallel -j $NCPU cutadapt -a file:01-info_files/adapters.fasta \
        -o 02-raw/trimmed/{/}.R1.fastq.gz \
        -p 02-raw/trimmed/{/}.R2.fastq.gz \
        -e 0.2 \
        -m 50 \
        {}.R1.fastq.gz \
        {}.R2.fastq.gz '2>&1' '>>' 10-log_files/"$TIMESTAMP"_01_cutadapt"${i%.fastq.gz}".log

