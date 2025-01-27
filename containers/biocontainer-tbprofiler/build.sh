#!/bin/bash
set -uex

# NOTE: Make sure you've set the environment correctly and are logged in to the registry.

TBPROFILER_VERSION=6.3.0
DOCKER_NAMESPACE="lcerdeira/bratb"

CONTAINER_NAME="$DOCKER_NAMESPACE/biocontainer-tbprofiler:$TBPROFILER_VERSION"

echo "Building container : $CONTAINER_NAME "

docker build -t $CONTAINER_NAME .
CONTAINER_ID=$(docker run -d $CONTAINER_NAME)
docker commit $CONTAINER_ID $CONTAINER_NAME
docker push $CONTAINER_NAME
docker stop $CONTAINER_ID
