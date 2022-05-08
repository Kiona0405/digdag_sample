ARG POSTGRES_IMAGE

FROM $POSTGRES_IMAGE

USER postgres
COPY --chown=postgres ./config/postgresql.conf /etc/postgresql/postgresql.conf 

ENTRYPOINT ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
