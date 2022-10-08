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

INPUTDIR=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/pilon.fasta
WORKDIR=/data/users/mwannier/FS22_Assembly/evaluation/busco

cd $WORKDIR

singularity exec \
--bind $INPUTDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $INPUTDIR -m genome --lineage brassicales_odb10 --cpu 4 -o canu_busco