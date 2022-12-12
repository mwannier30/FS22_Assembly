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

#import module
module add UHTS/Analysis/mummer/4.0.0beta1

#create output directory if doesn't exists and move to it
if ! [ -d /data/users/mwannier/FS22_Assembly/comparison/canu_flyeRef ]; then
    mkdir /data/users/mwannier/FS22_Assembly/comparison/canu_flyeRef
fi

cd /data/users/mwannier/FS22_Assembly/comparison/canu_flyeRef

#set variables
REFFILE=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta
CANU=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta

#run nucmer
nucmer \
    --prefix canu_flyeRef \
    --breaklen 1000 \
    --mincluster 1000 \
    $REFFILE \
    $CANU

#create mummerplot
mummerplot \
    -R $REFFILE \
    -Q $CANU \
    --filter \
    -t png \
    --large \
    --layout \
    --prefix canu_flyeRef \
    canu_flyeRef.delta