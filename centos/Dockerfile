FROM centos:7.5.1804

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    yum install -y logrotate crontabs && \
    yum clean all

ENTRYPOINT ["docker-entrypoint.sh"]

CMD bash
