#!/bin/bash

BROKER_ID=${BROKER_ID:-}
KAFKA_DATA_DIR=${KAFKA_DATA_DIR:-/opt/kafka/data/kafka}
ZK_CONNECT=${ZK_CONNECT:-localhost:2181}
JAVA_JVM_MEM=${JAVA_JVM_MEM:-}
KAFKA_OTHER_OPTS=${KAFKA_OTHER_OPTS:-}
KAFKA_JMX_PORT=${KAFKA_JMX_PORT:-9999}

run_env(){
	if [[ -n ${JAVA_JVM_MEM} ]];then
		KAFKA_HEAP_OPTS="-Xms${JAVA_JVM_MEM} -Xmx${JAVA_JVM_MEM}"
	fi
}

updata_config(){
	if [[ -z $BROKER_ID ]];then
		BROKER_ID=`echo ${HOSTNAME} | awk -F - '{print $2}'`
		if [[ -n `echo $BROKER_ID| sed -n "/^[0-9]\+$/p"` ]];then
			sed -i "s/broker.id=0/broker.id=${BROKER_ID}/" /opt/kafka/config/server.properties
		fi
	else
		sed -i "s/broker.id=0/broker.id=${BROKER_ID}/" /opt/kafka/config/server.properties
	fi
	sed -i "/exec/iexport JMX_PORT=${KAFKA_JMX_PORT}" /opt/kafka/bin/kafka-server-start.sh
	sed -i "s%log.dirs=/tmp/kafka-logs%log.dirs=${KAFKA_DATA_DIR}%" /opt/kafka/config/server.properties
	sed -i "s%zookeeper.connect=localhost:2181%zookeeper.connect=${ZK_CONNECT}%" /opt/kafka/config/server.properties
	if [[ ${ZK_CONNECT} = 'localhost:2181' ]];then
		sed -i "s%dataDir=/tmp/zookeeper%dataDir=/opt/kafka/data/zookeeper%" /opt/kafka/config/zookeeper.properties
		/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties &
	fi
}

run_env
updata_config
exec "$@" ${KAFKA_OTHER_OPTS}