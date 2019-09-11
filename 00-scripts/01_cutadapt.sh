#!/bin/bash

#script to run gbsx
#see full documentation at: https://github.com/GenomicsCoreLeuven/GBSX
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
NCPU=8 #number of CPU, can be set to any number
INFO_FILES="01-info_files"
#can be customized very easily
if [ ! -d "03-demultiplex/" ]  ; then
    echo "creation du dossier" ;
    mkdir 03-demultiplex/;
fi


outfile="03-demultiplex"
folder="02-raw/trimmed"
path="./GBSX/releases/GBSX_v1.3"
barcode=$INFO_FILES/barcode_list.txt
rad="-rad true"
gzip="-gzip true"
#qual="-q Illumina1.8"
ls -1 $folder/*.R1.fastq.gz | sed 's/.R1.fastq.gz//g' |
parallel -j $NCPU java -jar $path/GBSX_v1.3.jar --Demultiplexer \
    -f1 {}.R1.fastq.gz \
    -f2 {}.R2.fastq.gz \
    -i $barcode $gzip $rad $qual -o ${outfile} &>> ./10-log_files/${TIMESTAMP}_gbsx.log
