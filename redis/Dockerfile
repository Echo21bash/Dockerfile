FROM centos:7.5.1804

LABEL name="CentOS7 redis"

ENV PATH=/opt/redis/bin:$PATH \
    REDIS_VERSION=5.0.9

ADD docker-entrypoint.sh /opt/

RUN yum install -y make gcc iproute\
    && mkdir -p /opt/redis/{etc,data} /tmp/redis \
    && redis_down_url=https://mirrors.huaweicloud.com/redis/redis-${REDIS_VERSION}.tar.gz \
    && echo Downloading redis-${REDIS_VERSION}.tar.gz... \
    && curl -sl -o /tmp/redis.tar.gz ${redis_down_url} \
    && tar zxf /tmp/redis.tar.gz --strip-components 1 -C /tmp/redis \
    && cd /tmp/redis && make && cd /tmp/redis/src && make PREFIX=/opt/redis install \
    && mv /tmp/redis/redis.conf /opt/redis/etc \
    && chmod +x /opt/docker-entrypoint.sh \
    && ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -rf /tmp/redis.tar.gz /tmp/redis \
    && rpm -e --nodeps make gcc cpp glibc-devel glibc-headers kernel-headers libgomp libmpc mpfr \
    && yum clean all \
    && rm -rf /var/cache/yum

EXPOSE 6379

WORKDIR /opt/redis

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

CMD ["redis-server","/opt/redis/etc/redis.conf"]
