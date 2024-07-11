#!/usr/bin/env nextflow

include { TBPROFILER_PROFILE } from "./modules/nf-modules-hub/profile"

/*
#==============================================
params
#==============================================
*/


/*
#==============================================
tb-profiler
#==============================================
*/

workflow {
    ch_in_tbProfiler = Channel.fromFilePairs(params.file_pattern)
                                .map { t -> [[id: t[0]], t[1]]} 

    TBPROFILER_PROFILE ( ch_in_tbProfiler )
}

