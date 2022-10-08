#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=Merqury
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mwannier/merqury_%j.o
#SBATCH --error=/data/users/mwannier/error_merqury_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Assembler/canu/2.1.1;

PROJDIR=/data/users/mwannier/FS22_Assembly
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/merqury
FLYE=/data/users/mwannier/FS22_Assembly/polishing/flye/pilon_flye/pilon.fasta
CANU=/data/users/mwannier/FS22_Assembly/polishing/canu/pilon_canon/pilon.fasta

READ1=/data/users/mwannier/FS22_Assembly/participant_2/Illumina/ERR3624577_1.fastq.gz
READ2=/data/users/mwannier/FS22_Assembly/participant_2/Illumina/ERR3624577_2.fastq.gz

k=21

cd $OUTDIR

# prepare meryl dbs
singularity exec \
    --bind $PROJDIR \
    /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
    meryl k=$k count output read1.meryl $READ1 ; \
    meryl k=$k count output read2.meryl $READ2 ; \
    meryl union-sum output Illumina.meryl read*.meryl

# merqury assembly evaluation for flye
singularity exec \
--bind ${PROJDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
$OUTDIR/Illumina.meryl \
$FLYE \
$OUTDIR/flye

# merqury assembly evaluation for canu
singularity exec \
--bind ${PROJDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
$OUTDIR/Illumina.meryl \
$CANU \
$OUTDIR/canu