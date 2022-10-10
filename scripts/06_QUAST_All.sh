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

DATA_polished_canu=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta
DATA_polished_flye=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta
DATA_canu=/data/users/mwannier/FS22_Assembly/assembly/canu/canu_assembly.contigs.fasta
DATA_flye=/data/users/mwannier/FS22_Assembly/assembly/flye/assembly.fasta
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast/all
PROJDIR=/data/users/mwannier/FS22_Assembly

singularity exec \
--bind $PROJDIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py $DATA_polished_canu $DATA_polished_flye $DATA_canu $DATA_flye \
--eukaryote --est-ref-size 130000000 --labels canu_p,flye_p,canu,flye --large --threads 4 -o $OUTDIR