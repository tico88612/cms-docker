FROM ubuntu:20.04
RUN apt update && \
    apt install -yy --no-install-recommends \
                build-essential \
                python3.8 \
                python3.8-dev \
                python3-pip \
                libpq-dev \
                libcups2-dev \
                libyaml-dev \
                libffi-dev \
                gettext-base \
                iputils-ping \
                netcat && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --user-group --home-dir /cms cmsuser

RUN mkdir /cms
COPY dependency/cms /cms
ENV PYTHONPATH=/cms
RUN pip3 install -r /cms/requirements.txt

RUN chown -R cmsuser /cms
RUN chmod -R u+x /cms/scripts/
RUN cd /cms && python3 setup.py install

# copy scripts
RUN mkdir /scripts
COPY images/cms-base/cms-entrypoint.sh /scripts/
COPY dependency/wait-for-it/wait-for-it.sh /scripts/
RUN chmod -R u+x /scripts

# copy cms config
COPY config /cms/config

# configure entrypoint script
ENV HOME /cms
WORKDIR /cms
ENTRYPOINT ["/scripts/cms-entrypoint.sh"]
CMD bash