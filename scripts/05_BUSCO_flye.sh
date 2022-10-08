#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=28G
#SBATCH --time=12:00:00
#SBATCH --job-name=busco_flye
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=error,end
#SBATCH --partition=pall
#SBATCH --output=/data/users/mwannier/output_busco_flye_%j.o
#SBATCH --error=/data/users/mwannier/error_busco_flye_%j.e

INPUTDIR=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/pilon.fasta
WORKDIR=/data/users/mwannier/FS22_Assembly/evaluation/busco

cd $WORKDIR

singularity exec \
--bind $INPUTDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $INPUTDIR -m genome --lineage brassicales_odb10 --cpu 4 -o flye_busco