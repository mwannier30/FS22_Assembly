#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --job-name=busco_summary
#SBATCH --mail-user=maelle.wannier@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mwannier/FS22_Assembly/output_%j.o
#SBATCH --error=/data/users/mwannier/FS22_Assembly/error_%j.e
#SBATCH --partition=pall


#mkdir /data/users/mwannier/FS22_Assembly/evaluation/busco/summary
cd /data/users/mwannier/FS22_Assembly/evaluation/busco/summary
OUTDIR=/data/users/mwannier/FS22_Assembly/evaluation/busco/summary

cp /data/users/mwannier/FS22_Assembly/evaluation/busco/canu_busco/short_summary.specific.brassicales_odb10.canu_busco.txt \
    $OUTDIR
cp /data/users/mwannier/FS22_Assembly/evaluation/busco/flye_busco/short_summary.specific.brassicales_odb10.flye_busco.txt \
    $OUTDIR
cp /data/users/mwannier/FS22_Assembly/evaluation/busco/trinity_busco/short_summary.specific.brassicales_odb10.trinity_busco.txt \
    $OUTDIR

WORKDIR=/data/users/mwannier/FS22_Assembly/

singularity run \
    /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
    python3 scripts/generate_plot.py -wd $OUTDIR
