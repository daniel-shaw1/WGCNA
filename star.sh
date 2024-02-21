#!/bin/bash
#SBATCH --job-name=SRA
#SBATCH --partition=batch
#SBATCH --ntasks-per-node=20
#SBATCH --ntasks=1
#SBATCH --mem=100gb
#SBATCH --time=90:00:00
#SBATCH --output=star.%j.out
#SBATCH --error=star.%j.err


cd $SLURM_SUBMIT_DIR

module load STAR/2.7.10b-GCC-11.3.0

STAR --genomeDir /scratch/des65576/Mouse/RNA/genome/ \
--runThreadN 18 \
--readFilesIn SRR2761723.fastq \
--outFileNamePrefix 61723_out \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard
