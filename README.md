<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/braseqtb/braseqtb)](https://github.com/braseqtb/braseqtb/releases) -->
<!-- [![Anaconda-Server Badge](https://anaconda.org/bioconda/braseqtb/badges/downloads.svg)](https://anaconda.org/bioconda/braseqtb) -->
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/braseqtb/braseqtb)

![braseqtb Logo](data/braseqtb-logo.png)

# braseqtb
BraSeqTB is a flexible pipeline for the detection of antimicrobial resistance in Mycobacterium tuberculosis.

braseqtb can be split into two main parts:
[braseqtb Analysis Pipeline](https://braseqtb.github.io/latest/beginners-guide/), and
[braseqtb Tools](https://braseqtb.github.io/latest/braseqtb-tools/).


BraSeqTB Analysis Pipeline is the main *per-isolate* workflow in BraSeqTB. Built with
[Nextflow](https://www.nextflow.io/), input FASTQs (local or available from SRA/ENA)
are put through numerous analyses including: quality control, assembly, annotation,
minmer sketch queries, sequence typing, and more.

![braseqtb Overview](data/braseqtb-workflow.jpg)

BraSeqTB Tools are a set a independent workflows for comparative analyses. The comparative analyses
may include summary reports, pan-genome, or phylogenetic tree construction. Using the
[predictable output structure](https://braseqtb.github.io/latest/full-guide/) of braseqtb you can
pick and choose which samples to include for processing with a braseqtb Tool.

BraSeqTB was inspired by [Staphopia](https://staphopia.github.io/) and MAGMA [MAGMA](https://github.com/TORCH-Consortium/MAGMA?tab=readme-ov-file#Prerequisites) 

# Documentation
Documentation for braseqtb is available at https://braseqtb.github.io/.

# Quick Start
```
mamba create -y -n braseqtb -c conda-forge -c bioconda braseqtb
conda activate braseqtb
braseqtb datasets

# Paired-end
braseqtb --R1 R1.fastq.gz --R2 R2.fastq.gz --sample SAMPLE_NAME \
         --datasets datasets/ --outdir OUTDIR

# Single-End
braseqtb --SE SAMPLE.fastq.gz --sample SAMPLE --datasets datasets/ --outdir OUTDIR

# Multiple Samples
braseqtb prepare MY-FASTQS/ > fastqs.txt
braseqtb --fastqs fastqs.txt --datasets datasets --outdir OUTDIR

# Single ENA/SRA Experiment
braseqtb --accession SRX000000 --datasets datasets --outdir OUTDIR

# Multiple ENA/SRA Experiments
braseqtb search "staphylococcus aureus" > accessions.txt
braseqtb --accessions accessions.txt --dataset datasets --outdir ${OUTDIR}
```

# Installation
BraSeqTB has **a lot** of tools built into its workflow. All these tools
lead to numerous dependencies, and navigating dependencies can often turn into a very
frustrating process. With this in mind, from the onset BraSeqTB was developed to only
include programs that could be installable using [Conda](https://conda.io/en/latest/).

Conda is an open source package management system and environment management system that runs
on Windows, macOS and Linux. In other words, it makes it super easy to get the tools you need
installed! The [official Conda documentation](https://conda.io/projects/conda/en/latest/user-guide/install/index.html)
is a good starting point for getting started with Conda. BraSeqTB has been tested using the
[Miniforge installer](https://github.com/conda-forge/miniforgel), but the
[Anaconda installer](https://www.anaconda.com/distribution/) should work the same.

Once you have Conda all set up, you are ready to create an environment for BraSeqTB.

```
# Recommended
mamba create -n braseqtb -c conda-forge -c bioconda braseqtb

# or with standard conda
conda create -n braseqtb -c conda-forge -c bioconda braseqtb
```

After a few minutes you will have a new conda environment suitably named *braseqtb*. To
activate this environment, you will can use the following command:

```
conda activate braseqtb
```

And voilà, you are all set to get started processing your data!

# Please Cite Datasets and Tools
If you have used BraSeqTB in your work, please be sure to cite any datasets or tools you may
have used. [A list of each dataset/tool used by BraSeqTB has been made available](https://braseqtb.github.io/latest/impact-and-outreach/acknowledgements/). 

*If a citation needs to be updated please let me know!*

# Acknowledgements
BraSeqTB is truly a case of *"standing upon the shoulders of giants"*. Nearly every component
of BraSeqTB was created by others and made freely available to the public.

# Feedback
Your feedback is very valuable! If you run into any issues using BraSeqTB, have questions, or have some ideas to improve BraSeqTB, I highly encourage you to submit it to the [Issue Tracker](https://github.com/braseqtb/braseqtb/issues).

# License
[MIT License](https://raw.githubusercontent.com/braseqtb/braseqtb/master/LICENSE)

# Citation

# Author

* Louise Cerdeira
* Twitter: [@louisecerdeira](https://twitter.com/louisecerdeira)

<!-- * Naila
* Twitter: [@](https://twitter.com/)

* Ana Márcia Guimarães
* Twitter: [@anaguimaraes](https://twitter.com/) -->

## Funding

Support for this project came from an CNPq...