FROM rootww/java:8u181

LABEL name="centos7 JDK8 Elasticsearch"

ENV ELASTICSEARCH_HOME=/opt/elasticsearch PATH=$PATH:/opt/elasticsearch/bin

RUN mkdir -p /opt/elasticsearch/data /opt/elasticsearch/logs && \
    elasticsearch_down_url='https://mirrors.huaweicloud.com/elasticsearch' && \
    elasticsearch_ver=6.8.11 && \
    echo Downloading elasticsearch-${elasticsearch_ver}.tar.gz... && \
    curl -Ls -o /tmp/elasticsearch.tar.gz ${elasticsearch_down_url}/${elasticsearch_ver}/elasticsearch-${elasticsearch_ver}.tar.gz && \
    curl -Ls -o /usr/bin/gosu "https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64" && \
    chmod a+x /usr/bin/gosu && \
    tar zxf /tmp/elasticsearch.tar.gz --strip-components 1 -C /opt/elasticsearch && \
    rm -rf /tmp/elasticsearch.tar.gz && \
    adduser -d /opt/elasticsearch elasticsearch && \
    chown -R elasticsearch.elasticsearch /opt/elasticsearch

ADD docker-entrypoint.sh /opt/elasticsearch/bin/docker-entrypoint.sh

RUN chmod +x /opt/elasticsearch/bin/docker-entrypoint.sh

WORKDIR /opt/elasticsearch

EXPOSE 9200 9300

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["elasticsearch"]
