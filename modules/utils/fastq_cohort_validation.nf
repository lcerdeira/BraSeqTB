process UTILS_FASTQ_COHORT_VALIDATION {
    tag "joint_name: ${params.vcf_name}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
        path("fastq_reports/*")
        path(bratb_validated_samplesheet_json)

    output:
        path("bratb_analysis.json"), emit: bratb_analysis_json

    script:

        """
        csvtk concat fastq_reports/* |  csvtk csv2json -k file > merged_fastq_reports.json

        fastq_cohort_validation.py ${bratb_validated_samplesheet_json} merged_fastq_reports.json bratb_analysis.json

        rm merged_fastq_reports.json

        """


    stub:

        """
        touch ${params.vcf_name}.passed.tsv ${params.vcf_name}.failed.tsv
        """

}
