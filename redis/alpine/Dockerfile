FROM rootww/alpine-glibc:3.9-2.29

LABEL name="alpine redis"

ENV PATH=/opt/redis/bin:$PATH \
    REDIS_VERSION=5.0.5

RUN apk add --update --no-cache --virtual build-deps make gcc linux-headers musl-dev && \
    mkdir -p /opt/redis/{etc,data} /tmp/redis && \
    redis_down_url=https://mirrors.huaweicloud.com/redis/redis-${REDIS_VERSION}.tar.gz && \
    echo Downloading redis-${REDIS_VERSION}.tar.gz... && \
    wget -q -O /tmp/redis.tar.gz ${redis_down_url} && \
    tar zxf /tmp/redis.tar.gz --strip-components 1 -C /tmp/redis && \
    cd /tmp/redis && make && cd /tmp/redis/src && make PREFIX=/opt/redis install && \
    mv /tmp/redis/redis.conf /opt/redis/etc && \
    apk del build-deps && \
    rm -rf /tmp/redis.tar.gz /tmp/redis /var/cache/apk/*

ADD docker-entrypoint.sh /opt/redis/bin

ADD health-check /opt/redis/bin

RUN chmod +x /opt/redis/bin/docker-entrypoint.sh && \
	chmod +x /opt/redis/bin/health-check

EXPOSE 6379

WORKDIR /opt/redis

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["redis-server","/opt/redis/etc/redis.conf"]