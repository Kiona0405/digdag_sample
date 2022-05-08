#! /usr/bin/env bash
set -xe

here=$(dirname "$(readlink -f "$0")")
cd $here

source ./env.sh

./rm_volume.sh

# clean up tmp container
set +e
TMP_CONTAINER=dummy
docker stop $TMP_CONTAINER
docker rm $TMP_CONTAINER
set -e

docker volume create $WORKFLOW_VOLUME
docker volume create $DATABASE_VOLUME

docker run \
    -itd \
    --name $TMP_CONTAINER\
    -v $WORKFLOW_VOLUME:/root/project \
    -v $DATABASE_VOLUME:/root/database \
    $BASE_IMAGE

docker cp ../project/* $TMP_CONTAINER:/root/project/
docker exec -it $TMP_CONTAINER ls /root/project
docker stop $TMP_CONTAINER
docker rm $TMP_CONTAINER
