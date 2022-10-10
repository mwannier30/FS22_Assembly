#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=compare_canu_ref
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mwannier/compare_canu_ref_%j.o
#SBATCH --error=/data/users/mwannier/compare_canu_ref_%j.e
#SBATCH --partition=pcourseassembly

module add UHTS/Analysis/mummer/4.0.0beta1

mkdir /data/users/mwannier/FS22_Assembly/comparison/canu
cd /data/users/mwannier/FS22_Assembly/comparison/canu

REFFILE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
CANU=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta

nucmer \
    --prefix canu \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFFILE \
    $CANU

mummerplot \
    -R $REFFILE \
    -Q $CANU \
    --filter \
    -t png \
    --large \
    --layout \
    --prefix canu \
    canu.delta