FROM centos:7.5.1804

LABEL name="CentOS7 redis"

ENV PATH=/opt/redis/bin:$PATH \
    REDIS_VERSION=5.0.9 \
    REDIS_PORT=6379 \
    REDIS_PASSWORD=passw0ord \
    REDIS_RUN_MODE=standard \
    REDIS_MASTER_PASSWORD="passw0ord" \
    MAX_MEMORY=100mb

ADD docker-entrypoint.sh /opt/

RUN yum install -y make gcc \
    && mkdir -p /opt/redis/{etc,data} /tmp/redis \
    && redis_down_url=http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz \
    && echo Downloading redis-${REDIS_VERSION}.tar.gz... \
    && curl -sl -o /tmp/redis.tar.gz ${redis_down_url} \
    && tar zxf /tmp/redis.tar.gz --strip-components 1 -C /tmp/redis \
    && cd /tmp/redis && make && cd /tmp/redis/src && make PREFIX=/opt/redis install \
    && mv /tmp/redis/redis.conf /opt/redis/etc \
    && chmod +x /opt/docker-entrypoint.sh \
    && rm -rf /tmp/redis.tar.gz /tmp/redis

EXPOSE $REDIS_PORT

WORKDIR /opt

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
