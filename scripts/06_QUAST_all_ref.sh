#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=28G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast_canu
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pcourseassembly
#SBATCH --output=/data/users/mwannier/output_canu_QUAST_%j.o
#SBATCH --error=/data/users/mwannier/error_canu_QUAST_%j.e

module add UHTS/Quality_control/quast/4.6.0;

DATA_polished_canu=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta
DATA_polished_flye=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta
DATA_canu=/data/users/mwannier/FS22_Assembly/assembly/canu/canu_assembly.contigs.fasta
DATA_flye=/data/users/mwannier/FS22_Assembly/assembly/flye/assembly.fasta

REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
GFF=/data/courses/assembly-annotation-course/references/*.gff

OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast/all_ref


quast.py $DATA_polished_canu $DATA_polished_flye $DATA_canu $DATA_flye -R $REF --eukaryote \
--labels canu_p,flye_p,canu,flye --threads 4 -G $GFF -o $OUTDIR
