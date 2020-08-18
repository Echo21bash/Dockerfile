#!/bin/bash

BROKER_ID=${BROKER_ID:-}
KAFKA_DATA_DIR=${KAFKA_DATA_DIR:-/opt/kafka/data}
ZK_CONNECT=${ZK_CONNECT:-localhost:2181}
KAFKA_HEAP_OPTS=${KAFKA_HEAP_OPTS:--Xmx1G -Xms1G}
KAFKA_OTHER_OPTS=${KAFKA_OTHER_OPTS:-}

updata_config(){
	if [[ -z $BROKER_ID ]];then
		BROKER_ID=`echo ${HOSTNAME} | awk -F - '{print $2}'`
		if [[ -n `echo $BROKER_ID| sed -n "/^[0-9]\+$/p"` ]];then
			sed -i "s/broker.id=0/broker.id=${BROKER_ID}/" /opt/kafka/config/server.properties
		fi
	else
		sed -i "s/broker.id=0/broker.id=${BROKER_ID}/" /opt/kafka/config/server.properties
	fi
	sed -i "s@#listeners=PLAINTEXT://:9092@listeners=PLAINTEXT://:9092@" /opt/kafka/config/server.properties
	sed -i "s@log.dirs=/tmp/kafka-logs@log.dirs=${KAFKA_DATA_DIR}@" /opt/kafka/config/server.properties
	sed -i "s@zookeeper.connect=localhost:2181@zookeeper.connect=${ZK_CONNECT}@" /opt/kafka/config/server.properties
	if [[ ${ZK_CONNECT} = 'localhost:2181' ]];then
		sed -i "s@dataDir=/tmp/zookeeper@dataDir=/opt/kafka/logs/zookeeper@" /opt/kafka/config/zookeeper.properties
		/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties &
	fi
}

updata_config

exec "$@" ${KAFKA_OTHER_OPTS}