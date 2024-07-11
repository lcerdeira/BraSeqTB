#!/bin/bash

# Java path dir or added Java path inside user bash profile
java_path="~/jdk-20.0.1/bin/java"

# GATK path dir or added GATK path inside user bash profile
gatk_path="~/gatk-4.4.0.0"

# Reference file (fasta format) complete path

referencefile="NC0009623.fasta"

# Directory with BAM files
bam_dir="/bam"
var_dir="/vcall"

# Loop over BAM files
for bam_file in "${bam_dir}"/*-sorted-named-dupl.bam; do
	# Extract the file name without the extension
	filename=$(basename "$bam_file")
	sample_name="${filename%-sorted-named-dupl.bam}"
	
	# Output file name for variants
	output_vcf="${var_dir}/${sample_name}-variants.vcf"
	
	# Command to call variants with GATK HaplotypeCaller
	$java_path -jar ${gatk_path}/gatk-package-4.4.0.0-local.jar HaplotypeCaller --emit-ref-confidence BP_RESOLUTION -R $referencefile -I "$bam_file" --output-mode EMIT_ALL_ACTIVE_SITES -O "$output_vcf"
	
	echo "Variantes chamadas para $sample_name"
	
	# Output file name for variants with probabilities
	output_prob_vcf="${var_dir}/${sample_name}-variants-prob.vcf"
	
	# Command to calculate variant probabilities with GATK CalculateGenotypePosteriors
	$java_path -jar ${gatk_path}/gatk-package-4.4.0.0-local.jar CalculateGenotypePosteriors -R $referencefile -V "$output_vcf" -O "$output_prob_vcf"
	
	echo "probabilities variants calculated for $sample_name"
	
done
