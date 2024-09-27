<img src='data/braseqtb-logo.png' width="150" height="90">    

![Main Code Base](https://img.shields.io/github/languages/top/LaPAM-USP/braseqtb)
![Version](https://img.shields.io/badge/version-1.0-red)
![License](https://img.shields.io/badge/license-GPLv3-blue)
![Last Commit](https://img.shields.io/github/last-commit/LaPAM-USP/braseqtb)
![Open Issues](https://img.shields.io/github/issues-raw/LaPAM-USP/braseqtb)

# BraTB
BraTB is a flexible pipeline for detecting antimicrobial resistance in Mycobacterium tuberculosis.

BraTB Analysis Pipeline is the main per-isolate workflow in BraTB. Built with
[Nextflow](https://www.nextflow.io/), input FASTQs (local or available from SRA/ENA)
are put through numerous analyses, including quality control, assembly, annotation,
minmer sketch queries, sequence typing, and more.

![bratb Overview](data/braseqtb-workflow.jpg)

BraTB Tools are set as independent workflows for comparative analyses. The comparative analyses
may include summary reports, pan-genome, or phylogenetic tree construction. Using the
[predictable output structure](https://braseqtb.github.io/latest/full-guide/) of BraTB, you can
choose which samples to include for processing with a BraTB Tool.

BraTB was inspired by [Staphopia](https://staphopia.github.io/) and MAGMA [MAGMA](https://github.com/TORCH-Consortium/MAGMA?tab=readme-ov-file#Prerequisites) 

### Documentation
Documentation for BraTB is available [here](https://github.com/LaPAM-USP/BraSeqTB/wiki).

### Please Cite Datasets and Tools
If you have used BraTB in your work, please be sure to cite any datasets or tools you may
have used. [A list of each dataset/tool used by BraTB has been made available](https://braseqtb.github.io/latest/impact-and-outreach/acknowledgements/). 

*If a citation needs to be updated, please let me know!*

### Acknowledgements
BraTB is genuinely a case of *"standing upon the shoulders of giants"*. Nearly every component
of BraTB was created by others and made freely available to the public.

### Feedback
Your feedback is precious! If you run into any issues using BraTB, have questions, or have some ideas to improve BraTB, I highly encourage you to submit them to the [Issue Tracker](https://github.com/braseqtb/braseqtb/issues).

### Citation

Zenodo

### Authors

* Louise Cerdeira
* Twitter: [@louisecerdeira](https://twitter.com/louisecerdeira)

* Naila Soler

* Taiana Tainá

* Ana Márcia Guimarães
* Twitter: [@anaguimaraes](https://twitter.com/anaguimaraes)

### Funding

Support for this project came from a CNPq.
