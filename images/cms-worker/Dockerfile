FROM tico88612/cms-base:latest

ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    openjdk-11-jdk-headless \
    fp-compiler \
    cgroup-lite zip \
    php7.4-cli php7.4-fpm \
    texlive-latex-base a2ps \
    phppgadmin a2ps haskell-platform rustc \
    mono-mcs \
    libcap-dev \
    libyaml-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# build &install isolate sandbox
RUN python3 /cms/prerequisites.py --as-root -y build_isolate
RUN python3 /cms/prerequisites.py --as-root -y install_isolate
RUN rm -rf /cms/isolate/*.o /cms/isolate/isolate

# copy container source
COPY images/cms-worker/worker-entrypoint.sh /scripts/
RUN chown -R cmsuser /scripts/
RUN chmod -R a+x /scripts/

COPY config /cms/config

EXPOSE 26000
ENTRYPOINT [ "/scripts/cms-entrypoint.sh", "/scripts/worker-entrypoint.sh" ]
CMD [ "cmsWorker" ]