#!/bin/bash

ES_CLUSTER_NAME=${ES_CLUSTER_NAME:-}
ES_CLUSTER_HOSTS=${ES_CLUSTER_HOSTS:-}
ES_NODE_NAME=${ES_NODE_NAME:-}
ES_JAVA_OPTS=${ES_JAVA_OPTS:--Xms512m -Xmx512m}
ES_OTHER_OPTS=${ES_OTHER_OPTS:-}
run_env(){

	export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ $ES_JAVA_OPTS"

}

config_set(){

	[[ -n ${ES_NODE_NAME} ]] && sed -i "s/#node.name:.*/node.name: ${ES_NODE_NAME}/" /opt/elasticsearch/config/elasticsearch.yml
	[[ -n ${ES_CLUSTER_NAME} ]] && sed -i "s/#cluster.name:.*/cluster.name: ${ES_CLUSTER_NAME}/" /opt/elasticsearch/config/elasticsearch.yml
	[[ -n ${ES_CLUSTER_HOSTS} ]] && sed -i "s/#discovery.zen.ping.unicast.hosts:.*/discovery.zen.ping.unicast.hosts: ${ES_CLUSTER_HOSTS}/" /opt/elasticsearch/config/elasticsearch.yml
	sed -i "s/#network.host:.*/network.host: 0.0.0.0/" /opt/elasticsearch/config/elasticsearch.yml

}

run_env
config_set
exec gosu elasticsearch "$@" ${ES_OTHER_OPTS}
