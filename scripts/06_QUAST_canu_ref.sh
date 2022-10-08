#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=28G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast_canu_ref
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pcourseassembly
#SBATCH --output=/data/users/mwannier/output_canu_QUAST_%j.o
#SBATCH --error=/data/users/mwannier/error_canu_QUAST_%j.e

module add UHTS/Quality_control/quast/4.6.0;

DATA=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/pilon.fasta
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
GFF=/data/courses/assembly-annotation-course/references/*.gff
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast/Canu_ref
PROJDIR=/data/users/mwannier/FS22_Assembly

quast.py $DATA -R $REF --eukaryote --labels canu_ref --threads 4 -G $GFF -o $OUTDIR

