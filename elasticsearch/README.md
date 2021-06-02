关于该Dockerfile的使用说明
===

    可以通过变量修改默认配置默认值如下
    ES_CLUSTER_NAME=${ES_CLUSTER_NAME:-}
    ES_CLUSTER_HOSTS=${ES_CLUSTER_HOSTS:-}
    ES_NODE_NAME=${ES_NODE_NAME:-}
    ES_JAVA_OPTS=${ES_JAVA_OPTS:--Xms1G -Xmx1G}
    ES_OTHER_OPTS=${ES_OTHER_OPTS:-}
    示例
        - name: ES_OTHER_OPTS
          value: '-E cluster.routing.allocation.disk.threshold_enabled=false'

