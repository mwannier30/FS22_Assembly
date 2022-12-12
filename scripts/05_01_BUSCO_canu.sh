#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=26G
#SBATCH --time=12:00:00
#SBATCH --job-name=busco_canu
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=error,end
#SBATCH --partition=pall
#SBATCH --output=/data/users/mwannier/output_busco_canu_%j.o
#SBATCH --error=/data/users/mwannier/error_busco_canu_%j.e

#set variables
PROJDIR=/data/users/mwannier/FS22_Assembly
INPUTDIR=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/pilon.fasta
UNPOLISHED=/data/users/mwannier/FS22_Assembly/assembly/canu/canu_assembly.contigs.fasta
WORKDIR=/data/users/mwannier/FS22_Assembly/evaluation/busco

#move to working directory
cd $WORKDIR

#run busco on polished assembly
singularity exec \
--bind $PROJDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $INPUTDIR -m genome --lineage brassicales_odb10 --cpu 4 -o canu

#run busco on unpolished assembly
singularity exec \
--bind $PROJDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $UNPOLISHED -m genome --lineage brassicales_odb10 --cpu 4 -o canu_unpolished