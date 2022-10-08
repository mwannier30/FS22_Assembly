#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast_flye
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pcourseassembly
#SBATCH --output=/data/users/mwannier/output_flye_QUAST_%j.o
#SBATCH --error=/data/users/mwannier/error_flye_QUAST_%j.e

module add UHTS/Quality_control/quast/4.6.0;

DATA=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/pilon.fasta
REF=/data/courses/assembly-annotation-course/references/*.fa
GFF=/data/courses/assembly-annotation-course/references/*.gff
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast
PROJDIR=/data/users/mwannier/FS22_Assembly


quast.py $DATA -R $REF --eukaryote --labels flye_ref --threads 4 -G $GFF -o $OUTDIR