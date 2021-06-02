FROM rootww/java:8u181

LABEL name="Centos7 JDK8 Elasticsearch"

ENV ELASTICSEARCH_HOME=/opt/elasticsearch PATH=$PATH:/opt/elasticsearch/bin

RUN mkdir -p /opt/elasticsearch/data /opt/elasticsearch/logs && \
    elasticsearch_down_url='https://mirrors.huaweicloud.com/elasticsearch' && \
    elasticsearch_ver=6.8.11 && \
    useradd elasticsearch && \
    echo Downloading elasticsearch-${elasticsearch_ver}.tar.gz... && \
    curl -Ls -o /tmp/elasticsearch.tar.gz ${elasticsearch_down_url}/${elasticsearch_ver}/elasticsearch-${elasticsearch_ver}.tar.gz && \
    curl -Ls -o /usr/bin/gosu "https://download.fastgit.org/tianon/gosu/releases/download/1.12/gosu-amd64" && \
    tar zxf /tmp/elasticsearch.tar.gz --strip-components 1 -C /opt/elasticsearch && \
    chmod a+x /usr/bin/gosu && \
    chown -R elasticsearch.elasticsearch /opt/elasticsearch && \
    rm -rf /tmp/elasticsearch.tar.gz /opt/elasticsearch/jdk

ADD docker-entrypoint.sh /opt/elasticsearch/bin/docker-entrypoint.sh

ADD health-check /opt/elasticsearch/bin/health-check

RUN chmod +x /opt/elasticsearch/bin/docker-entrypoint.sh && \
    chmod +x /opt/elasticsearch/bin/health-check

WORKDIR /opt/elasticsearch

EXPOSE 9200 9300

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["elasticsearch"]
