FROM rootww/java:11.0.2

LABEL name="Centos7 JDK11 Logstash"

ENV LOGSTASH_HOME=/opt/logstash PATH=$PATH:/opt/logstash/bin

RUN mkdir -p /opt/logstash/data /opt/logstash/logs /opt/logstash/config.d && \
    logstash_down_url='https://mirrors.huaweicloud.com/logstash' && \
    logstash_ver=7.12.1 && \
    useradd logstash && \
    echo Downloading logstash-${logstash_ver}.tar.gz... && \
    curl -Ls -o /tmp/logstash.tar.gz ${logstash_down_url}/${logstash_ver}/logstash-${logstash_ver}-linux-x86_64.tar.gz && \
    curl -Ls -o /usr/bin/gosu "https://download.fastgit.org/tianon/gosu/releases/download/1.12/gosu-amd64" && \
    tar zxf /tmp/logstash.tar.gz --strip-components 1 -C /opt/logstash && \
    rm -rf /tmp/logstash.tar.gz && \
    rm -rf /opt/logstash/jdk && \
    chmod a+x /usr/bin/gosu && \
    chown -R logstash.logstash /opt/logstash

ADD docker-entrypoint.sh /opt/logstash/bin/docker-entrypoint.sh


RUN chmod +x /opt/logstash/bin/docker-entrypoint.sh

WORKDIR /opt/logstash

EXPOSE 8080

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["logstash"]
