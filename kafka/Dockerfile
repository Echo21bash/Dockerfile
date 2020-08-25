FROM rootww/java:8u181

LABEL name="centos7 JDK8 kafka"

ENV KAFKA_HOME=/opt/kafka PATH=$PATH:/opt/kafka/bin

RUN mkdir -p /opt/kafka/data /opt/kafka/logs \
    && kafka_down_url='https://mirrors.huaweicloud.com/apache/kafka' \
    && kafka_ver=2.1.1 \
    && echo Downloading kafka-${kafka_ver}.tgz... \
    && curl -Ls -o /tmp/kafka.tgz ${kafka_down_url}/${kafka_ver}/kafka_2.11-${kafka_ver}.tgz \
    && tar zxf /tmp/kafka.tgz --strip-components 1 -C /opt/kafka \
    && rm -rf /tmp/kafka.tgz

ADD docker-entrypoint.sh /opt/kafka/bin/docker-entrypoint.sh

RUN chmod +x /opt/kafka/bin/docker-entrypoint.sh

WORKDIR /opt/kafka

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["kafka-server-start.sh","/opt/kafka/config/server.properties"]