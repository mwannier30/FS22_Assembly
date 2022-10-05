#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --time=12:00:00
#SBATCH --job-name=busco
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=error,end
#SBATCH --partition=pall
#SBATCH --output=/data/users/mwannier/output_busco_trinity_%j.o
#SBATCH --error=/data/users/mwannier/error_busco_trinity_%j.e

INPUT=/data/users/mwannier/FS22_Assembly/assembly/trinity/Trinity.fasta
WORKDIR=/data/users/mwannier/FS22_Assembly/evaluation/busco

cd $WORKDIR

singularity exec \
--bind $INPUT \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $INPUT -m tran --lineage brassicales_odb10 --cpu 4 -o trinity_busco