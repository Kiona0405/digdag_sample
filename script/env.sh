#! /usr/bin/env bash

export BASE_IMAGE=centos:centos7.9.2009
export POSTGRES_IMAGE=postgres:13.6
export POSTGRES_TAG=nao-postgres:0.1
export DIGDAG_TAG=nao-digdag:0.1

# for digdag workflow files
export WORKFLOW_VOLUME=digdag_workflow_volume
# for postgres' files
export DATABASE_VOLUME=digdag_database

export DIGDAG_CONTAINER=digdag_server
export DIGDAG_PORT=65432
export DIGDAG_ADMIN_PORT=65433

export POSTGRES_CONTAINER=postgres_server
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export POSTGRES_PORT=5432
export POSTGRES_DB=postgres 
export POSTGRES_DATA=/var/lib/postgresql/data/pgdata
export POSTGRES_HOST_AUTH_METHOD=trust

