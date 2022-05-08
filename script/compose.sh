#! /usr/bin/env bash
set -x

here=$(dirname $0)
cd $here/../


docker-compose \
    --env-file ./script/env.sh \
    down

docker-compose \
    -p digdag_sample \
    --env-file ./script/env.sh \
    up \
    --remove-orphans \
    --force-recreate
