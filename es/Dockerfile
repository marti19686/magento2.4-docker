FROM alpine

RUN apk --no-cache  add bash curl openjdk8 openssl                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
RUN adduser -D -u 555 -h /usr/share/elasticsearch elasticsearch                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

ARG ELASTIC_VERSION
ARG ES_DOWNLOAD_URL
ARG ES_JAVA_OPTS

ENV ELASTIC_VERSION=5.3.0
ENV ES_DOWNLOAD_URL=https://artifacts.elastic.co/downloads/elasticsearch 
ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

WORKDIR /usr/share/elasticsearch

# Download/extract defined ES version. busybox tar can't strip leading dir.
RUN wget ${ES_DOWNLOAD_URL}/elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    EXPECTED_SHA=$(wget -O - ${ES_DOWNLOAD_URL}/elasticsearch-${ELASTIC_VERSION}.tar.gz.sha1) && \
    test $EXPECTED_SHA == $(sha1sum elasticsearch-${ELASTIC_VERSION}.tar.gz | awk '{print $1}') && \
    tar zxf elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    chown -R elasticsearch:elasticsearch elasticsearch-${ELASTIC_VERSION} && \
    mv elasticsearch-${ELASTIC_VERSION}/* . && \
    rmdir elasticsearch-${ELASTIC_VERSION} && \
    rm elasticsearch-${ELASTIC_VERSION}.tar.gz

RUN set -ex && for esdirs in config data logs; do \
        mkdir -p "$esdirs"; \
        chown -R elasticsearch:elasticsearch "$esdirs"; \
    done

# Install Plugin
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin list
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3

# Remove x-pack 'https://github.com/elastic/elasticsearch-docker/issues/35#issuecomment-285912424
# RUN /usr/share/elasticsearch/bin/elasticsearch-plugin remove  x-pack
RUN rm -rf plugins/x-pack


USER elasticsearch

USER root

USER elasticsearch
CMD ["/bin/bash"]