FROM rootww/java:8u181-alpine-3.9

LABEL name="alpine3.9 JDK8 Activemq5.15"

ENV ACTIVEMQ_HOME /opt/activemq

RUN mkdir -p /opt/activemq \
    && activemq_down_url='https://mirrors.huaweicloud.com/apache/activemq/' \
    && activemq_ver='5.15.9' \
    && echo Downloading apache-activemq-${activemq_ver}.tar.gz... \
    && wget -q -O /tmp/activemq.tar.gz ${activemq_down_url}/${activemq_ver}/apache-activemq-${activemq_ver}-bin.tar.gz \
    && tar zxf /tmp/activemq.tar.gz --strip-components 1 -C /opt/activemq \
    && rm -rf /tmp/activemq.tar.gz

WORKDIR $ACTIVEMQ_HOME

EXPOSE 61616 8161

CMD ["/bin/sh", "-c", "bin/activemq console"]
