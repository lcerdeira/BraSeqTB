include { FASTQ_VALIDATOR } from '../modules/fastq_utils/validator.nf' addParams ( params.FASTQ_VALIDATOR  )
include { UTILS_FASTQ_COHORT_VALIDATION } from '../modules/utils/fastq_cohort_validation.nf' addParams ( params.UTILS_FASTQ_COHORT_VALIDATION  )

workflow VALIDATE_FASTQS_WF {
    take:
         samplesheet_json
         ready

    main:

 
    fastqs_ch = samplesheet_json
        .splitJson()
        .map {
            if (it.R2) {
                [it.bratb_sample_name, [it.R1, it.R2]]
            } else {

                [it.bratb_sample_name, [it.R1]]
            }
        }.transpose()




    FASTQ_VALIDATOR( fastqs_ch, ready )


    UTILS_FASTQ_COHORT_VALIDATION( FASTQ_VALIDATOR.out.fastq_report.collect(), samplesheet_json )


    validated_fastqs_ch = UTILS_FASTQ_COHORT_VALIDATION.out.bratb_analysis_json
                            .splitJson()
                            .filter {it.value.fastqs_approved}
                            .map {
                                    if (it.value.R2) {
                [it.value.bratb_sample_name, [bam_rg_string: it.value.bratb_bam_rg_string, paired: true], [it.value.R1, it.value.R2]]
                                    } else {
                [it.value.bratb_sample_name, [bam_rg_string: it.value.bratb_bam_rg_string, paired: false] , [it.value.R1]]
                                    }
                            }

     emit:

        approved_fastqs_ch = validated_fastqs_ch


}
