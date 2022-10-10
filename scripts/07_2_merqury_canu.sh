#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mwannier/merqury_canu_%j.o
#SBATCH --error=/data/users/mwannier/merqury_canu_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Assembler/canu/2.1.1;

#directories for Singularity binding
PROJDIR=/data/users/mwannier/FS22_Assembly/
READSDIR=/data/courses/assembly-annotation-course/raw_data/

#create output directory
mkdir /data/users/mwannier/FS22_Assembly/evaluation/merqury/canu
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/merqury/canu

#directory for fasta files
CANU=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/canu.fasta

#illumina reads
READ1=/data/courses/assembly-annotation-course/raw_data/C24/participant_2/Illumina/ERR3624577_1.fastq.gz
READ2=/data/courses/assembly-annotation-course/raw_data/C24/participant_2/Illumina/ERR3624577_2.fastq.gz

cd $OUTDIR

k=18

# prepare meryl dbs
singularity exec \
    --bind $PROJDIR,$READSDIR \
    /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
    meryl k=$k count output read1.meryl $READ1 ; \
    meryl k=$k count output read2.meryl $READ2 ; \
    meryl union-sum output Illumina.meryl read*.meryl

#Illumina meryl file
ILLMERYL=/data/users/mwannier/FS22_Assembly/evaluation/merqury/canu/Illumina.meryl


# merqury assembly evaluation for canu
singularity exec \
    --bind $PROJDIR,$READSDIR \
    /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
    merqury.sh \
        $ILLMERYL \
        $CANU \
        canu