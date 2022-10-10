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

mkdir /data/users/mwannier/FS22_Assembly/comparison/flye_canuRef
cd /data/users/mwannier/FS22_Assembly/comparison/flye_canuRef

REFFILE=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta
FLYE=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta

nucmer \
    --prefix flye_canuRef \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFFILE \
    $FLYE

mummerplot \
    -R $REFFILE \
    -Q $FLYE \
    --filter \
    -t png \
    --large \
    --layout \
    --prefix flye_canuRef \
    flye_canuRef.delta