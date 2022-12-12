#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mwannier/output_fastqc_%j.o
#SBATCH --error=/data/users/mwannier/error_fastqc_%j.e
#SBATCH --partition=pcourseassembly


#import modules
module load UHTS/Quality_control/fastqc/0.11.9;

#Create variables
OUTDIR=/data/users/mwannier/assembly_annotation_course/read_QC/fastqc

#change working directory to directory containing fastq files
cd ../participant_2

#loop over fastq files and do a fastqc analysis
for file in $(ls ./*/*); do
	fastqc -o $OUTDIR -f fastq $file
done

#change working directory to the output directory
cd $OUTDIR 

#do a multiqc analysis
multiqc -o ../multiqc ./