#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=compare_flye_ref
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mwannier/compare_flye_ref_%j.o
#SBATCH --error=/data/users/mwannier/compare_flye_ref_%j.e
#SBATCH --partition=pcourseassembly

module add UHTS/Analysis/mummer/4.0.0beta1

#create output directory if doesn't exists and move to it
if ! [ -d mkdir /data/users/mwannier/FS22_Assembly/comparison/flye ]; then
    mkdir mkdir /data/users/mwannier/FS22_Assembly/comparison/flye
fi

cd /data/users/mwannier/FS22_Assembly/comparison/flye

#set variables
REFFILE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta

#run nucmer
nucmer \
    --prefix flye \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFFILE \
    $FLYE

#create mummerplot
mummerplot \
    -R $REFFILE\
    -Q $FLYE\
    --filter \
    -t png \
    --large \
    --layout \
    --prefix flye \
    flye.delta