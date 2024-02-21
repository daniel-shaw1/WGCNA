
#!/bin/bash
#SBATCH --job-name=htseq
#SBATCH --partition=batch
#SBATCH --ntasks-per-node=20
#SBATCH --ntasks=1
#SBATCH --mem=250gb
#SBATCH --time=90:00:00
#SBATCH --output=htseq.%j.out
#SBATCH --error=htseq.%j.err


cd $SLURM_SUBMIT_DIR

ml HTSeq/2.0.2-foss-2022a
ml SAMtools/1.16.1-GCC-11.3.0

# Define input and output directories
input_dir="/scratch/des65576/Mouse/RNA/"
output_dir="/scratch/des65576/Mouse/RNA/counts_output/"

# Define path to the reference GTF/GFF file
reference_gtf="/scratch/des65576/Mouse/RNA/genome/mm10.ncbiRefSeq.gtf"

# List all BAM files in the input directory
bam_files=("$input_dir"/61762_outAligned.sortedByCoord.out.bam)
# Get the BAM file corresponding to the current SLURM array task ID
current_bam="${bam_files[$SLURM_ARRAY_TASK_ID - 1]}"

# Extract the base filename (without extension) for naming the output file
base_filename=$(basename "$current_bam" .bam)

# Define the output file path
output_file="$output_dir/$base_filename.counts.txt"

# Run HTSeq to count reads for the current BAM file
htseq-count -f bam -r pos -s no -t exon -i gene_id "$current_bam" "$reference_gtf" > "$output_file"
