#!/usr/bin/env bash

set -e

# NOTE: Please replace `conda` with `mamba` if it is installed for faster installs.
resolverCondaBinary="conda" # pick either conda OR mamba

#===========================================================
#
# NOTE: By default, the conda environments are expected by the `conda_local` profile to be created within `bratb/conda_envs` directory

$resolverCondaBinary env create -p bratb-env --file conda_envs/bratb-env.yml 

#===========================================================

#NOTE: Setup the tbprofiler env with WHO v2 Database

$resolverCondaBinary env create -p bratb-tbprofiler-env --file conda_envs/bratb-tbprofiler-env.yml

echo "INFO: Activate conda env with tb-profiler and setup the WHO database"
eval "$(conda shell.bash hook)"
#Note after mamba installation peharps the conda envs messy the conda path so one tip, if not works the command below, added the full PATH or fix the conda path
conda activate "./conda_envs/bratb-tbprofiler-env"

#echo "INFO: Use WHO-v2 database in bratb-tbprofiler-env"
#tb-profiler update_tbdb --commit bdace1f82d948ce0001e1dade6eb93d2da9c47e5 --logging DEBUG

#echo "INFO: Use BraTB branch from tbdb database in bratb-tbprofiler-env"
tb-profiler update_tbdb --commit 30f8bc37df15affa378ebbfbd3e1eb4c5903056e --logging DEBUG

echo "INFO: Deactivate the bratb-tbprofiler-env "
conda deactivate
