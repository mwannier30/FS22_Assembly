#!/usr/bin/env bash


#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --time=12:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mwannier/output_flye_%j.o
#SBATCH --error=/data/users/mwannier/error_flye_%j.e
#SBATCH --partition=pcourseassembly


module load UHTS/Assembler/flye/2.8.3;

PACBIO=/data/users/mwannier/FS22_Assembly/participant_2/pacbio/*
OUTDIR=/data/users/mwannier/FS22_Assembly/assembly/flye/

flye \
	--pacbio-raw $PACBIO \
	--genome-size 130m \
	--out-dir $OUTDIR
