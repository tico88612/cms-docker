FROM cms-base:latest

RUN apt update && \
    apt install -yy --no-install-recommends \
                cppreference-doc-en-html && \
    rm -rf /var/lib/apt/lists/*

COPY images/cms-web-contest/web-contest-entrypoint.sh /scripts
RUN chown -R cmsuser /scripts
RUN chmod -R u+x /scripts

COPY config /cms/config

EXPOSE 8888
EXPOSE 21000
ENTRYPOINT [ "/scripts/cms-entrypoint.sh", "/scripts/web-contest-entrypoint.sh" ]
CMD [ "cmsContestWebServer" ]