#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=01:00:00
#SBATCH --job-name=kmer_counting
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mwannier/output_kmer_%j.o
#SBATCH --error=/data/users/mwannier/error_kmer_%j.e
#SBATCH --partition=pcourseassembly

module load UHTS/Analysis/jellyfish/2.3.0;

jellyfish count \
-C -m 19 -s 2G -t 4 -o /data/users/mwannier/assembly_annotation_course/read_QC/kmer_counting/Illumina.jf \
<(zcat /data/users/mwannier/assembly_annotation_course/participant_2/Illumina/ERR3624577_1.fastq.gz) \
<(zcat /data/users/mwannier/assembly_annotation_course/participant_2/Illumina/ERR3624577_2.fastq.gz) 

jellyfish histo \
-t 4 /data/users/mwannier/assembly_annotation_course/read_QC/kmer_counting/Illumina.jf \
> /data/users/mwannier/assembly_annotation_course/read_QC/kmer_counting/Illumina.histo
