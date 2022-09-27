#!/usr/bin/env bash


#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mwannier/output_fastqc_%j.o
#SBATCH --error=/data/users/mwannier/error_fastqc_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Assembler/canu/2.1.1;


INPUTDIR = /data/users/mwannier/FS22_Assembly/participant_2/pacbio/*
OUTDIR = /data/users/mwannier/FS22_Assembly/assembly/canu


 canu -p canu_assembly \
 -d $OUTDIR \
 genomeSize=130m \
 -pacbio-raw $INPUTDIR \
 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
 gridOptions="--partition=pall --mail-user=maelle.wannier@students.unibe.ch"