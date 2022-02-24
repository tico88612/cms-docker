FROM tico88612/cms-base:latest

RUN apt update && \
    apt install -yy --no-install-recommends \
                postgresql-client && \
    rm -rf /var/lib/apt/lists/*

COPY images/cms-db-init/cms-db-init-entrypoint.sh /scripts/
RUN chmod -R u+x /scripts

ENTRYPOINT ["/scripts/cms-db-init-entrypoint.sh"]