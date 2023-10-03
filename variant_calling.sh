#!/bin/bash

# Directory with BAM files
bam_dir="/bam"
var_dir="/vcall"

# Loop over BAM files
for bam_file in "${bam_dir}"/*-sorted-named-dupl.bam; do
	# Extract the file name without the extension
	filename=$(basename "$bam_file")
	sample_name="${filename%-sorted-named-dupl.bam}"
	
	# Output file name for variants
	output_vcf="${var_dir}/${sample_name}-variantes.vcf"
	
	# Command to call variants with GATK HaplotypeCaller
	/home/geninfo/ncamargo/jdk-20.0.1/bin/java -jar /home/geninfo/ncamargo/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar HaplotypeCaller --emit-ref-confidence BP_RESOLUTION -R NC0009623.fasta -I "$bam_file" --output-mode EMIT_ALL_ACTIVE_SITES -O "$output_vcf"
	
	echo "Variantes chamadas para $sample_name"
	
	# Output file name for variants with probabilities
	output_prob_vcf="${var_dir}/${sample_name}-variantes-prob.vcf"
	
	# Command to calculate variant probabilities with GATK CalculateGenotypePosteriors
	/home/geninfo/ncamargo/jdk-20.0.1/bin/java -jar /home/geninfo/ncamargo/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar CalculateGenotypePosteriors -R NC0009623.fasta -V "$output_vcf" -O "$output_prob_vcf"
	
	echo "Variantes com probabilidades calculadas para $sample_name"
	
done
