#!/bin/bash

#Zk集群名
ZK_CLUSTER_NAME=${ZK_CLUSTER_NAME:-cluster1}
#Zk集群地址
ZK_CLUSTER_LIST=${ZK_CLUSTER_LIST:-ZKSERVER}

run_env(){
	mkdir -p ${KE_HOME}/kms/webapps/ke
	cd ${KE_HOME}/kms/webapps/ke
	${JAVA_HOME}/bin/jar -xf $KE_HOME/kms/webapps/ke.war
	rm -rf ${KE_HOME}/kms/webapps/ke/WEB-INF/classes/*.properties
	cd ${KE_HOME}
}

config_set(){
	
	read -r -a zk_cluster_name <<< "$(tr ',;' ' ' <<< "$ZK_CLUSTER_NAME")"
	zk_cluster_list=(${ZK_CLUSTER_LIST})
	
	sed -i "s/cluster1.zk.list=/# cluster1.zk.list=/" ${KE_HOME}/conf/system-config.properties
	sed -i "s/cluster2.zk.list=/# cluster2.zk.list=/" ${KE_HOME}/conf/system-config.properties
	sed -i "s/cluster1.kafka.eagle.offset.storage=/# cluster1.kafka.eagle.offset.storage=/" ${KE_HOME}/conf/system-config.properties
	sed -i "s/cluster2.kafka.eagle.offset.storage=/# cluster2.kafka.eagle.offset.storage=/" ${KE_HOME}/conf/system-config.properties

	sed -i "s/kafka.eagle.zk.cluster.alias=.*/kafka.eagle.zk.cluster.alias=${ZK_CLUSTER_NAME}/" ${KE_HOME}/conf/system-config.properties
	i=0
	for zk in ${zk_cluster_name[@]}
	do
		sed -i "/kafka.eagle.zk.cluster.alias=.*/a${zk_cluster_name[$i]}.zk.list=${zk_cluster_list[$i]}" ${KE_HOME}/conf/system-config.properties
		sed -i "/# cluster2.kafka.eagle.offset.storage=.*/a${zk_cluster_name[$i]}.kafka.eagle.offset.storage=kafka" ${KE_HOME}/conf/system-config.properties
		((i++))
	done
	
	sed -i "s?kafka.eagle.url=.*?kafka.eagle.url=jdbc:sqlite:/opt/kafka-eagle/db/ke.db?" ${KE_HOME}/conf/system-config.properties
	cp ${KE_HOME}/conf/*.properties ${KE_HOME}/kms/webapps/ke/WEB-INF/classes/

}

run_env
config_set
exec "$@"
