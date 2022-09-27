#!/usr/bin/env bash


#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mwannier/output_fastqc_%j.o
#SBATCH --error=/data/users/mwannier/error_fastqc_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Assembler/trinityrnaseq/2.5.1;

INPUTDIR = /data/users/mwannier/participant_2/RNAseq
OUTDIR = /data/users/mwannier/assembly/trinity/

Trinity --seqType fq --left $INPUTDIR/SRR1584462_1.fastq.gz --right $INPUTDIR/SRR1584462_2.fastq.gz \
    --output $OUTDIR