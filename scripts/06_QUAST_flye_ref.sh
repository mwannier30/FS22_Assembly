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

DATA=/data/users/mwannier/FS22_Assembly/polishing/flye/*.fasta
REF=/data/courses/assembly-annotation-course/references
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast

quast.py $DATA -r $REF --eukaryote --labels flye_ref --large --threads 4 --pacbio -o $OUTDIR