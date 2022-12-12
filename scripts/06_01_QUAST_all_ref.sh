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

#set variables
DATA_polished_canu=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta
DATA_polished_flye=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/flye.fasta

PROJDIR=/data/users/mwannier/FS22_Assembly

REFDIR=/data/courses/assembly-annotation-course/references
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
GFF=/data/courses/assembly-annotation-course/references/*.gff

OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/quast/all_ref


#run quast with ref genome 
singularity exec \
--bind $PROJDIR,$REFDIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py $DATA_polished_canu $DATA_polished_flye \
-r $REF -g $GFF --eukaryote --labels canu,flye --large --threads 4 -o $OUTDIR