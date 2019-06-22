FROM rootww/jdk8

ADD zkui-*.jar /opt/jar/zkui.jar
ADD config.cfg /opt/jar/config.cfg
ADD docker-entrypoint.sh /opt/jar/docker-entrypoint.sh

ENTRYPOINT ["/opt/jar/docker-entrypoint.sh"]

EXPOSE 9090
