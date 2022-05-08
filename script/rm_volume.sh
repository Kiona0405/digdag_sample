#! /usr/bin/env bash
set -xe

here=$(dirname "$(readlink -f "$0")")
cd $here

source ./env.sh

docker volume rm -f $WORKFLOW_VOLUME
docker volume rm -f $DATABASE_VOLUME
