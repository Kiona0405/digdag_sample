#! /usr/bin/env bash

here=$(dirname "$(readlink -f "$0")")
cd $here/../

. $here/env.sh

docker-compose build \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    --build-arg POSTGRES_IMAGE=$POSTGRES_IMAGE
