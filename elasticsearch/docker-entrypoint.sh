#!/bin/bash

ES_CLUSTER_NAME=${ES_CLUSTER_NAME:-}
ES_CLUSTER_HOSTS=${ES_CLUSTER_HOSTS:-}
ES_NODE_NAME=${ES_NODE_NAME:-}
ES_JAVA_OPTS=${ES_JAVA_OPTS:--Xms1G -Xmx1G}
ES_OTHER_OPTS=${ES_OTHER_OPTS:-}
run_env(){
	export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ $ES_JAVA_OPTS"

}

config_set(){
	if [[ -n ${ES_CLUSTER_HOSTS} ]];then
		read -r -a host_list <<< "$(tr ',;' ' ' <<< "$ES_CLUSTER_HOSTS")"
		master_list=( "${host_list[@]}" )
		total_nodes=${#host_list[@]}
		minimum_master_nodes="$(((total_nodes+1+1)/2))"
		recover_after_nodes="$(((total_nodes+1+1)/2))"
		expected_nodes="$total_nodes"
		ES_VER=$(elasticsearch --version | grep Version: | awk -F "," '{print $1}' | awk -F ":" '{print $2}' | awk -F "." '{print $1}')
		
		if [[ "$ES_VER" -le 6 ]]; then
			sed -i "s/#discovery.zen.ping.unicast.hosts:.*/discovery.zen.ping.unicast.hosts: ${ES_CLUSTER_HOSTS}/" /opt/elasticsearch/config/elasticsearch.yml
        else
			sed -i "s/#discovery.seed_hosts:.*/discovery.seed_hosts: ${ES_CLUSTER_HOSTS}/" /opt/elasticsearch/config/elasticsearch.yml
        fi
		
		sed -i "/#discovery.zen.minimum_master_nodes:.*/adiscovery.zen.minimum_master_nodes: ${minimum_master_nodes}" /opt/elasticsearch/config/elasticsearch.yml
		sed -i "/#discovery.zen.minimum_master_nodes:.*/adiscovery.zen.ping_timeout: 60s" /opt/elasticsearch/config/elasticsearch.yml
		sed -i "/#discovery.zen.minimum_master_nodes:.*/adiscovery.initial_state_timeout: 5m" /opt/elasticsearch/config/elasticsearch.yml
		
		sed -i "/#gateway.recover_after_nodes.*/agateway.recover_after_nodes: ${recover_after_nodes}" /opt/elasticsearch/config/elasticsearch.yml
		sed -i "/#gateway.recover_after_nodes.*/agateway.expected_nodes: ${expected_nodes}" /opt/elasticsearch/config/elasticsearch.yml
	fi

	[[ -n ${ES_NODE_NAME} ]] && sed -i "s/#node.name:.*/node.name: ${ES_NODE_NAME}/" /opt/elasticsearch//config/elasticsearch.yml
	[[ -n ${ES_CLUSTER_NAME} ]] && sed -i "s/#cluster.name:.*/cluster.name: ${ES_CLUSTER_NAME}/" /opt/elasticsearch/config/elasticsearch.yml

	sed -i "s/#network.host:.*/network.host: 0.0.0.0/" /opt/elasticsearch/config/elasticsearch.yml
	echo "###############################config-info###############################"
	cat /opt/elasticsearch/config/elasticsearch.yml | grep -v "^#"
	echo "###############################config-info###############################"

}

run_env
config_set
exec gosu elasticsearch "$@" ${ES_OTHER_OPTS}
