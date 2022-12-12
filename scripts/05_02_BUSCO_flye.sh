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

#set variables
PROJDIR=/data/users/mwannier/FS22_Assembly
INPUTDIR=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/pilon.fasta
UNPOLISHED=/data/users/mwannier/FS22_Assembly/assembly/flye/assembly.fasta
WORKDIR=/data/users/mwannier/FS22_Assembly/evaluation/busco

#move to working directory
cd $WORKDIR

#run busco on polished assembly
singularity exec \
--bind $PROJDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $INPUTDIR -m genome --lineage brassicales_odb10 --cpu 4 -o flye

#run busco on unpolished assembly
singularity exec \
--bind $PROJDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $UNPOLISHED -m genome --lineage brassicales_odb10 --cpu 4 -o flye_unpolished