FROM alpine as download

ENV KE_HOME=/opt/kafka-eagle PATH=$PATH:/opt/kafka-eagle/bin EAGLE_VERSION=3.0.2

RUN mkdir -p /opt/kafka-eagle/conf;cd /opt && \
    wget --timeout=60 https://ghproxy.com/https://github.com/smartloli/kafka-eagle-bin/archive/v${EAGLE_VERSION}.tar.gz && \
    tar zxf v${EAGLE_VERSION}.tar.gz -C kafka-eagle --strip-components 1 && \
    cd kafka-eagle;tar zxf efak-web-${EAGLE_VERSION}-bin.tar.gz --strip-components 1 && \
    chmod +x /opt/kafka-eagle/bin/ke.sh && \
    chmod -R +x /opt/kafka-eagle/kms/bin && \
    rm -rf /opt/v${EAGLE_VERSION}.tar.gz /opt/kafka-eagle/kafka-eagle-web-${EAGLE_VERSION}-bin.tar.gz


FROM openjdk:8-alpine

RUN apk add gettext sqlite

COPY --from=download /opt/kafka-eagle /opt/kafka-eagle

ADD docker-entrypoint.sh /opt/kafka-eagle/bin

RUN chmod +x /opt/kafka-eagle/bin/docker-entrypoint.sh

EXPOSE 8048

WORKDIR /opt/kafka-eagle

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/opt/kafka-eagle/kms/bin/catalina.sh","run"]