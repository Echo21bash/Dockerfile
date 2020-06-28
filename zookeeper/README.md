关于该容器的使用说明
----
    1、该镜像同时支持无状态和有状态集群部署，集群环境变量SERVERS是集群的个数必须为奇数。
    2、使用StatefulSet部署集群时，zookeeper各pod通过集群域名解析$(podname).$(headless server name).$(namespace).svc.cluster.local连接
    3、使用Deployment部署集群时，zookeeper各pod通过服务发现$(server name)连接，服务名称通过容器名称截取，格式为必须为xxxx-数字
    4、持久化目录/opt/zookeeper/data
	5、可配置环境变量及默认值
	TICK_TIME=${TICK_TIME:-2000}
	INIT_LIMIT=${INIT_LIMIT:-10}
	SYNC_LIMIT=${SYNC_LIMIT:-5}
	HEAP=${HEAP:-512M}