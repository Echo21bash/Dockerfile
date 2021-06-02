关于该Dockerfile的使用说明
===

    可以通过变量修改默认配置默认值如下
    堆内存
    JAVA_JVM_MEM="1G"
    其他运行参数
    LOGSTASH_OTHER_OPTS="${JAVA_JVM_MEM:-}"

