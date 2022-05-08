#!/usr/bin/env bash
set -e

# rendering server.properties
envsubst \
    < /opt/digdag/config/server.properties \
    > /opt/digdag/config/server.properties.tmp
mv /opt/digdag/config/server.properties.tmp \
   /opt/digdag/config/server.properties

# # rendering pgpass file
# echo "$POSTGRES_CONTAINER:$POSTGRES_PORT:$POSTGRES_DB:$POSTGRES_USER:$POSTGRES_PASSWORD" > ~/.pgpass
# chmod 600 ~/.pgpass

# wait for postgresup
# until psql -h "$POSTGRES_CONTAINER" -U "$POSTGRES_USER" -p "$POSTGRES_PORT" -c '\l'; do
until psql -h "$POSTGRES_CONTAINER" -U "$POSTGRES_USER" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

>&2 echo "Postgres is up - executing command"

# start digdag server process in background
exec "$@"

# # push default projects
# project_root=/opt/digdag/project
# for project in $(ls $project_root);
# do
#     cd $project_root/$project
#     digdag push $project
# done

# # forward the digdag server process 
# fg %1
