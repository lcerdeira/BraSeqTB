#!/usr/bin/env bash
# build-containers
#
# Create a blank tool.
VERSION=3.0.0

if [[ $# == 0 ]]; then
    echo ""
    echo "create-tool.sh braseqtb_DIR SUBWORKFLOW_NAME SUBWORKFLOW_DESCRIPTION"
    echo ""
    echo "Example Command"
    echo "create-tool.sh /home/braseqtb/braseqtb roary 'Create a pan-genome with Roary and an optional core-genome phylogeny with IQTree.' "
    echo ""
    exit
fi

braseqtb_DIR=$1
SUBWORKFLOW=$2
SUBWORKFLOW_UPPER=${SUBWORKFLOW^^}
DESCRIPTION=$3
if [ -z "${braseqtb_DIR}" ] || [ -z "${SUBWORKFLOW}" ] || [ -z "${DESCRIPTION}" ]; then
    echo "Got ${#} arguement"
    echo "Must give a path to braseqtb repository, tool name and tool description."
    exit 1
fi

if [ ! -d "${braseqtb_DIR}/sobworkflows/local/${SUBWORKFLOW}" ]; then
    cp -r ${braseqtb_DIR}/.skeleton/subworkflows ${braseqtb_DIR}/subworkflows/local/${SUBWORKFLOW}
    filenames=( "main.nf" "meta.yml" "test.nf" "test.yml" )
    for filename in "${filenames[@]}"; do
        sed -i -r 's/SUBWORKFLOW_NAME/'"${SUBWORKFLOW}"'/g' ${braseqtb_DIR}/subworkflows/local/${SUBWORKFLOW}/${filename}
        sed -i -r 's/SUBWORKFLOW_UPPER/'"${SUBWORKFLOW_UPPER}"'/g' ${braseqtb_DIR}/subworkflows/local/${SUBWORKFLOW}/${filename}
        sed -i -r 's/SUBWORKFLOW_DESCRIPTION/'"${DESCRIPTION}"'/g' ${braseqtb_DIR}/subworkflows/local/${SUBWORKFLOW}/${filename}
    done

    # Add test when called with '--wf'
    cp ${braseqtb_DIR}/.skeleton/tests/test.yml ${braseqtb_DIR}/tests/subworkflows/test_${SUBWORKFLOW}.yml
    sed -i -r 's/SUBWORKFLOW_NAME/'"${SUBWORKFLOW}"'/g' ${braseqtb_DIR}/tests/subworkflows/test_${SUBWORKFLOW}.yml
else
    echo "${SUBWORKFLOW} exists already, please verify. Not going to replace, exiting..."
    exit 1
fi
