#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=compare_flyeRef_canu
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mwannier/compare_flyeRef_canu_%j.o
#SBATCH --error=/data/users/mwannier/compare_flyeRef_canu_%j.e
#SBATCH --partition=pcourseassembly

module add UHTS/Analysis/mummer/4.0.0beta1

mkdir /data/users/mwannier/FS22_Assembly/comparison/canu_flyeRef
cd /data/users/mwannier/FS22_Assembly/comparison/canu_flyeRef

REFFILE=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta
CANU=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta

nucmer \
    --prefix canu_flyeRef \
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
    --prefix canu_flyeRef \
    canu_flyeRef.delta