#!/bin/sh

#conf redis
sed -i "s/^bind.*/bind 0.0.0.0/" /opt/redis/etc/redis.conf
sed -i 's#^dir ./#dir /opt/redis/data#' /opt/redis/etc/redis.conf
sed -i "s/# requirepass foobared/requirepass ${REDIS_PASSWORD}/" /opt/redis/etc/redis.conf
sed -i 's/appendonly no/appendonly yes/' /opt/redis/etc/redis.conf
if [ $REDIS_RUN_MODE = cluster ];then
  sed -i "s/^# masterauth <master-password>/masterauth ${REDIS_PASSWORD}/" /opt/redis/etc/redis.conf
  sed -i 's/# cluster-enabled yes/cluster-enabled yes/' /opt/redis/etc/redis.conf
  sed -i 's/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/' /opt/redis/etc/redis.conf
  sed -i 's/# cluster-node-timeout 15000/cluster-node-timeout 15000/' /opt/redis/etc/redis.conf
fi
#start redis
/opt/redis/bin/redis-server /opt/redis/etc/redis.conf

