#!/bin/sh

#conf redis
sed -i 's/^port 6379/port '${redis_port}'/' /opt/redis/etc/redis.conf
sed -i "s/# requirepass foobared/requirepass ${REDIS_PASSWORD}/" /opt/redis/etc/redis.conf
sed -i 's/appendonly no/appendonly yes/' /opt/redis/etc/redis.conf

#start redis
/opt/redis/bin/redis-server /opt/redis/etc/redis.conf
