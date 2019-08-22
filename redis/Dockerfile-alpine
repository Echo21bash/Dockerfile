FROM rootww/alpine-glibc:3.9-2.29

LABEL name="alpine redis"

ENV PATH=/opt/redis/bin:$PATH \
    REDIS_VERSION=5.0.5 \
    REDIS_PORT=6379 \
    REDIS_PASSWORD=passw0ord \
    REDIS_RUN_MODE=standard \
    REDIS_MASTER_PASSWORD="passw0ord" \
    MAX_MEMORY=100mb

ADD docker-entrypoint.sh /opt/

RUN apk add --update --no-cache --virtual build-deps make gcc linux-headers musl-dev \
    && mkdir -p /opt/redis/{etc,data} /tmp/redis \
    && redis_down_url=http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz \
    && echo Downloading redis-${REDIS_VERSION}.tar.gz... \
    && wget -q -O /tmp/redis.tar.gz ${redis_down_url} \
    && tar zxf /tmp/redis.tar.gz --strip-components 1 -C /tmp/redis \
    && cd /tmp/redis && make && cd /tmp/redis/src && make PREFIX=/opt/redis install \
    && mv /tmp/redis/redis.conf /opt/redis/etc \
    && chmod +x /opt/docker-entrypoint.sh \
    && apk del build-deps \
    && rm -rf /tmp/redis.tar.gz /tmp/redis /var/cache/apk/*

EXPOSE $REDIS_PORT

WORKDIR /opt

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
