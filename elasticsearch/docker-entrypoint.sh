#!/bin/bash

ES_CLUSTER_NAME=${ES_CLUSTER_NAME:-elasticsearch}
ES_CLUSTER_HOSTS=${ES_CLUSTER_HOSTS:-}
ES_HOSTS_DISCOVERY=${ES_HOSTS_DISCOVERY:-es-discovery}
ES_NODE_NAME=${ES_NODE_NAME:-node1}
ES_NODE_TYPE=${ES_NODE_TYPE:-single-node}
JAVA_JVM_MEM=${JAVA_JVM_MEM:-}
ES_OTHER_OPTS=${ES_OTHER_OPTS:-}

run_env(){
	if [[ -n ${JAVA_JVM_MEM} ]];then
		ES_JAVA_OPTS="-Xms${JAVA_JVM_MEM} -Xmx${JAVA_JVM_MEM}"
	fi
	export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ $ES_JAVA_OPTS"
	ES_VER=$(elasticsearch --version | grep Version: | awk -F "," '{print $1}' | awk -F ":" '{print $2}' | awk -F "." '{print $1}')
	export ES_VER=${ES_VER}
	
}

config_set(){
	###通用配置
	sed -i "s/#node.name:.*/node.name: ${ES_NODE_NAME}/" /opt/elasticsearch//config/elasticsearch.yml
	sed -i "s/#cluster.name:.*/cluster.name: ${ES_CLUSTER_NAME}/" /opt/elasticsearch/config/elasticsearch.yml
	sed -i "s/#network.host:.*/network.host: 0.0.0.0/" /opt/elasticsearch/config/elasticsearch.yml
	sed -i "/#action.destructive_requires_name:.*/i# 有了这个设置，最久未使用（LRU）的 fielddata 会被回收为新数据腾出空间" /opt/elasticsearch/config/elasticsearch.yml
	sed -i "/#action.destructive_requires_name:.*/iindices.fielddata.cache.size: 25%" /opt/elasticsearch/config/elasticsearch.yml
	sed -i "/#action.destructive_requires_name:.*/icluster.max_shards_per_node: 20000" /opt/elasticsearch/config/elasticsearch.yml
	
	if [[ ${ES_NODE_TYPE} = 'single-node' && -z ${ES_CLUSTER_HOSTS} ]];then
		sed -i "/network.host:.*/adiscovery.type: single-node" /opt/elasticsearch/config/elasticsearch.yml
	fi
	if [[ -n ${ES_CLUSTER_HOSTS} ]];then
		read -r -a host_list <<< "$(tr ',;' ' ' <<< "$ES_CLUSTER_HOSTS")"
		master_list=( "${host_list[@]}" )
		total_nodes=${#host_list[@]}
		minimum_master_nodes="$(((total_nodes+1+1)/2))"
		recover_after_nodes="$(((total_nodes+1+1)/2))"
		expected_nodes="$total_nodes"
		
		
		if [[ "$ES_VER" -le 6 ]]; then
			sed -i "s/#discovery.zen.ping.unicast.hosts:.*/discovery.zen.ping.unicast.hosts: ${ES_CLUSTER_HOSTS}/" /opt/elasticsearch/config/elasticsearch.yml
        else
			if [[ -n ${ES_HOSTS_DISCOVERY} ]];then
				sed -i "s/#discovery.seed_hosts:.*/discovery.seed_hosts: ${ES_HOSTS_DISCOVERY}/" /opt/elasticsearch/config/elasticsearch.yml
			fi
			sed -i "s/#cluster.initial_master_nodes:.*/cluster.initial_master_nodes: ${ES_CLUSTER_HOSTS}/" /opt/elasticsearch/config/elasticsearch.yml
        fi
		
		sed -i "/#discovery.zen.minimum_master_nodes:.*/adiscovery.zen.minimum_master_nodes: ${minimum_master_nodes}" /opt/elasticsearch/config/elasticsearch.yml
		sed -i "/#discovery.zen.minimum_master_nodes:.*/adiscovery.zen.ping_timeout: 60s" /opt/elasticsearch/config/elasticsearch.yml
		sed -i "/#discovery.zen.minimum_master_nodes:.*/adiscovery.initial_state_timeout: 5m" /opt/elasticsearch/config/elasticsearch.yml
		
		sed -i "/#gateway.recover_after_nodes.*/agateway.recover_after_nodes: ${recover_after_nodes}" /opt/elasticsearch/config/elasticsearch.yml
		sed -i "/#gateway.recover_after_nodes.*/agateway.expected_nodes: ${expected_nodes}" /opt/elasticsearch/config/elasticsearch.yml
	fi

	echo "###############################Config-Info###############################"
	cat /opt/elasticsearch/config/elasticsearch.yml | grep -v "^#"
	echo "###############################Config-Info###############################"

}

run_env
config_set
exec gosu elasticsearch "$@" ${ES_OTHER_OPTS}
