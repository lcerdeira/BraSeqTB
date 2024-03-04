#!/bin/bash

# Directory of VCF files
vcf_dir="/vcf"

# Directory where the filtered files will be saved
output_dir="/out"

# Loop over VCF files
for vcf_file in "${vcf_dir}"/*.vcf; do
    # Extract the file name without extension
    base_name=$(basename "${vcf_file}" .vcf)

    # Filtered file name
    filtered_vcf="${output_dir}/${base_name}-filtered.vcf"

    # Compress VCF file using bgzip
    bgzip -c "${vcf_file}" > "${vcf_file}.gz"

    # Generate the index for the VCF file
    tabix -p vcf "${vcf_file}.gz"

    # Filter the VCF file
    bcftools view -R TB-drugs.bed -o "${filtered_vcf}" "${vcf_file}.gz"

    # Remove compressed VCF file
    rm "${vcf_file}.gz"

    # Remove index file
    rm "${vcf_file}.gz.tbi"
done


