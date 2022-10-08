#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=28G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast_canu
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pcourseassembly
#SBATCH --output=/data/users/mwannier/output_canu_QUAST_%j.o
#SBATCH --error=/data/users/mwannier/error_canu_QUAST_%j.e

module add UHTS/Quality_control/quast/4.6.0;

DATA=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/pilon.fasta
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast
PROJDIR=/data/users/mwannier/FS22_Assembly

singularity exec \
--bind $PROJDIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py $DATA --eukaryote --est-ref-size 130000000 --labels canu --large --threads 4 -o $OUTDIR