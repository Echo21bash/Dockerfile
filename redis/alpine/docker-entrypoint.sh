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
		#updata CLUSTER_ANNOUNCE_IP
		if [[ -n ${REDIS_OTHER_OPTS} ]];then
			CLUSTER_ANNOUNCE_IP=`echo ${REDIS_OTHER_OPTS} | grep -oE "cluster-announce-ip[\ ]{1,}[0-9\.]{1,}" | awk '{print$2}'`
			if [[ -z ${CLUSTER_ANNOUNCE_IP} ]];then
				CLUSTER_ANNOUNCE_IP=$(ip addr | grep -E 'eth[0-9a-z]{1,3}|eno[0-9a-z]{1,3}|ens[0-9a-z]{1,3}|enp[0-9a-z]{1,3}' | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v  "^255\.|\.255$|^127\.|^0\." | head -n 1)
			fi
		else
			CLUSTER_ANNOUNCE_IP=$(ip addr | grep -E 'eth[0-9a-z]{1,3}|eno[0-9a-z]{1,3}|ens[0-9a-z]{1,3}|enp[0-9a-z]{1,3}' | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v  "^255\.|\.255$|^127\.|^0\." | head -n 1)
		fi

		if [[ -f /opt/redis/data/nodes-6379.conf ]];then
			sed -i -e "/myself/ s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/${CLUSTER_ANNOUNCE_IP}/" /opt/redis/data/nodes-6379.conf
		fi
	fi

}

redis_conf
exec "$@" ${REDIS_OTHER_OPTS}

