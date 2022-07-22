FROM centos:7.5.1804

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV LANG=zh_CN.UTF-8

COPY CentOS7-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 && \
	chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    yum install -y logrotate crontabs && \
    yum clean all

ENTRYPOINT ["docker-entrypoint.sh"]

CMD bash
