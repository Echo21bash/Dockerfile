#!/bin/bash
REDIS_RUN_MODE=${REDIS_RUN_MODE:-standard}
REDIS_PASSWORD=${REDIS_PASSWORD:-}
REDIS_MASTER_PASSWORD=${REDIS_PASSWORD}
REDIS_OTHER_OPTS=${REDIS_OTHER_OPTS:-}
MAX_MEMORY=${MAX_MEMORY:-100mb}

redis_conf(){

	#conf redis
	sed -i 's/^bind.*/bind 0.0.0.0/' /opt/redis/etc/redis.conf
	sed -i 's#^dir ./#dir /opt/redis/data#' /opt/redis/etc/redis.conf
	sed -i "s/# maxmemory <bytes>/maxmemory ${MAX_MEMORY}/" /opt/redis/etc/redis.conf
	sed -i 's/appendonly no/appendonly yes/' /opt/redis/etc/redis.conf
	if [[ -n ${REDIS_PASSWORD} ]];then
		sed -i "s/# requirepass foobared/requirepass ${REDIS_PASSWORD}/" /opt/redis/etc/redis.conf
	fi
	
	if [[ ${REDIS_RUN_MODE} = 'cluster' ]];then
		if [[ -n ${REDIS_MASTER_PASSWORD} ]];then
			sed -i "s/^# masterauth <master-password>/masterauth ${REDIS_PASSWORD}/" /opt/redis/etc/redis.conf
		fi
		sed -i 's/# cluster-enabled yes/cluster-enabled yes/' /opt/redis/etc/redis.conf
		sed -i 's/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/' /opt/redis/etc/redis.conf
		sed -i 's/# cluster-node-timeout 15000/cluster-node-timeout 15000/' /opt/redis/etc/redis.conf
	fi
}

redis_conf
exec "$@" ${REDIS_OTHER_OPTS}

