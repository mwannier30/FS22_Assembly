#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=28G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall
#SBATCH --output=/data/users/mwannier/output_canu_QUAST_%j.o
#SBATCH --error=/data/users/mwannier/error_canu_QUAST_%j.e

module add UHTS/Quality_control/quast/4.6.0;

DATA=/data/users/mwannier/FS22_Assembly/polishing/canu/*.fasta
REF=/data/courses/assembly-annotation-course/references
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast

quast.py $DATA -r $REF --eukaryote --large --labels canu_ref --threads 4 --pacbio -o $OUTDIR