FROM mambaorg/micromamba:1.4.9 AS base

#NOTE: The conda env file has been copied via the build script
COPY --chown=$MAMBA_USER:$MAMBA_USER mapping-env.yml /tmp/mapping-env.yml

RUN micromamba install -y -f /tmp/mapping-env.yml -n base

RUN micromamba install -y -n base conda-forge::procps-ng  && micromamba clean -a -y

FROM base AS snpeffdbsetup

ENV PATH /opt/conda/bin:$PATH

RUN snpEff download -v Mycobacterium_tuberculosis_gca_001397715 && cd /tmp
