FROM rootww/java:8u181-alpine

ENV KE_HOME=/opt/kafka-eagle PATH=$PATH:/opt/kafka-eagle/bin EAGLE_VERSION=2.0.2

RUN apk add gettext sqlite && \
    mkdir -p /opt/kafka-eagle/conf;cd /opt && \
    wget --timeout=30 https://download.fastgit.org/smartloli/kafka-eagle-bin/archive/v${EAGLE_VERSION}.tar.gz || \
    wget --timeout=30 https://github.com/smartloli/kafka-eagle-bin/archive/v${EAGLE_VERSION}.tar.gz && \
    tar zxf v${EAGLE_VERSION}.tar.gz -C kafka-eagle --strip-components 1 && \
    cd kafka-eagle;tar zxf kafka-eagle-web-${EAGLE_VERSION}-bin.tar.gz --strip-components 1 && \
    chmod +x /opt/kafka-eagle/bin/ke.sh && \
    chmod -R +x /opt/kafka-eagle/kms/bin && \
    rm -rf /opt/v${EAGLE_VERSION}.tar.gz /opt/kafka-eagle/kafka-eagle-web-${EAGLE_VERSION}-bin.tar.gz

ADD docker-entrypoint.sh /opt/kafka-eagle/bin

RUN chmod +x /opt/kafka-eagle/bin/docker-entrypoint.sh

EXPOSE 8048

WORKDIR /opt/kafka-eagle

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/opt/kafka-eagle/kms/bin/catalina.sh","run"]