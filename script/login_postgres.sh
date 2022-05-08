#! /usr/bin/env bash

here=$(dirname "$(readlink -f "$0")")
cd $here

source ./env.sh
docker exec -it $POSTGRES_CONTAINER /bin/bash
