#!/bin/bash
braseqtb="${PREFIX}/share/${PKG_NAME}-${PKG_VERSION}"
mkdir -p ${PREFIX}/bin ${braseqtb}

chmod 775 bin/*.py bin/helpers/*
cp bin/*.py ${PREFIX}/bin
cp bin/helpers/* ${PREFIX}/bin

chmod 775 bin/braseqtb/*
cp bin/braseqtb/* ${PREFIX}/bin

# Move braseqtb nextflow
mv bin/ conf/ data/ lib/ modules/ subworkflows/ tests/ workflows/ main.nf citations.yml nextflow.config ${braseqtb}
