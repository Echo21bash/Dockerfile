FROM rootww/java:8u181-alpine-3.9

ADD zkui-*.jar /opt/jar/zkui.jar

ADD config.cfg /opt/jar/config.cfg

ADD docker-entrypoint.sh /opt/docker-entrypoint.sh

RUN chmod +x /opt/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

EXPOSE 9090
