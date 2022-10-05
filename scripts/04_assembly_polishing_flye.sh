#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --time=12:00:00
#SBATCH --job-name=bowtie
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --partition=pall
#SBATCH --output=/data/users/mwannier/output_flye_polishing_%j.o
#SBATCH --error=/data/users/mwannier/error_flye_polishing_%j.e

module add UHTS/Aligner/bowtie2/2.3.4.1;

OUTDIR=/data/users/mwannier/FS22_Assembly/polishing/flye
FLYEDIR=/data/users/mwannier/FS22_Assembly/assembly/flye/assembly.fasta
ILLUMINA=/data/users/mwannier/FS22_Assembly/participant_2/Illumina/

if ! [ -d $OUTDIR ]; then
    mkdir $OUTDIR
fi

rm -rf $OUTDIR/*

cd $OUTDIR

bowtie2-build -f --threads 4 $FLYEDIR flye_index

INDEXDIR=/data/users/mwannier/FS22_Assembly/polishing/flye/flye_index

bowtie2 -x $INDEXDIR -q --sensitive-local -p 4 -1 $ILLUMINA/ERR3624577_1.fastq.gz -2 $ILLUMINA/ERR3624577_2.fastq.gz -S /data/users/mwannier/FS22_Assembly/polishing/flye/bowtie2_flye.sam

# convert sam to bam file
samtools view -bS bowtie2_flye.sam > bowtie2_flye.bam
samtools index bowtie2_flye.bam

#run pilon
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
--genome $FLYEDIR \
--bam bowtie2_canu.bam --outdir $OUTDIR/pilon_flye