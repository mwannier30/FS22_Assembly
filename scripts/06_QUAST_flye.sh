#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall
#SBATCH --output=/data/users/mwannier/output_flye_QUAST_%j.o
#SBATCH --error=/data/users/mwannier/error_flye_QUAST_%j.e

module add UHTS/Quality_control/quast/4.6.0;

DATA=/data/users/mwannier/FS22_Assembly/polishing/canu/*.fasta
REF=/data/courses/assembly-annotation-course/references
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast

quast.py $DATA --est-ref-size 130m --eukaryote --large --threads 4 --pacbio -o $OUTDIR