#!/bin/bash

# Java path dir or added Java path inside user bash profile

java_path="~/jdk-20.0.1/bin/java"

# GATK path dir or added GATK path inside user bash profile
gatk_path="~/gatk-4.4.0.0"

# Directory with read pairs
paired_dir="/directory"

# Output directory for the mapped BAM files
output_dir="/out"

# Loop over R1 files
for r1_file in ${paired_dir}/*_R1_paired.fq.gz; do
    # Extract name from R1 file
    filename=$(basename "$r1_file")
    sample_name="${filename%%_S*}"

    # Build the corresponding R2 file name
    r2_file=$(echo "$r1_file" | sed 's/_R1_/_R2_/')

    # Check if the R2 file exists
    if compgen -G "$r2_file" > /dev/null; then
        # Build the output path for the BAM file
        output_bam="${output_dir}/${sample_name}.bam"

        # Run the mapping with BWA and save to a BAM file using NC0009623.fasta as reference (TODO: add the sequence description)
        bwa mem -t 50 NC0009623.fasta "$r1_file" "$r2_file" | samtools view -bS - > "$output_bam"

        echo "Mapping finished for $sample_name"

        # BAM Sorting
        sorted_bam="${output_bam%.bam}-sorted.bam"
        samtools sort "$output_bam" -o "$sorted_bam"

        echo "Sorting finished for $sample_name"

        # Index of sorted BAM
        samtools index "$sorted_bam"

        echo "Index BAM sorted finished for $sample_name"

        # Renaming with Picard
        library_name=$(basename "$(dirname "$paired_dir")")
        named_bam="${output_dir}/${sample_name}-sorted-named.bam"
        $java_path -jar picard.jar AddOrReplaceReadGroups -I "$sorted_bam" -O "$named_bam" -RGID 1 -RGLB "$library_name" -RGPL ILLUMINA -RGPU unit1 -RGSM "$sample_name"

        echo "Read groups rename for $sample_name"

        # MarkDuplicates with Picard
        marked_dup_bam="${output_dir}/${sample_name}-sorted-named-dupl.bam"
        marked_dup_metrics="${output_dir}/${sample_name}-marked-dup-metrics.txt"
        $java_path -jar picard.jar MarkDuplicates -I "$named_bam" -O "$marked_dup_bam" -M "$marked_dup_metrics"

        echo "Duplicates flagged for $sample_name"

        # Index of BAM markdup
        samtools index "$marked_dup_bam"

        echo "Index BAM duplicates finished $sample_name"

    else
        echo "R2 corresponding file does not found $r1_file"
    fi
done

# Create sequence dictionary with GATK
$java_path  -jar {$gatk_path}/gatk-package-4.4.0.0-local.jar CreateSequenceDictionary -R NC0009623.fasta -O NC0009623.dict

echo "GATK dictionary created"


