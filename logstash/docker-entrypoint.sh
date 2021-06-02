#!/bin/bash
LOGSTASH_BASE_DIR="/opt/logstash"
LOGSTASH_DATA_DIR="${LOGSTASH_DATA_DIR:-${LOGSTASH_BASE_DIR}/data}"
LOGSTASH_CONF_DIR="${LOGSTASH_BASE_DIR}/config"
LOGSTASH_CONF_EXTRA_DIR="${LOGSTASH_BASE_DIR}/config.d"
LOGSTASH_BIN_DIR="${LOGSTASH_BASE_DIR}/bin"
LOGSTASH_LOG_DIR="${LOGSTASH_BASE_DIR}/logs"
LOGSTASH_CONF_FILENAME="${LOGSTASH_CONF_FILENAME:-logstash.conf}"
JAVA_JVM_MEM="${JAVA_JVM_MEM:-1G}"
LOGSTASH_OTHER_OPTS="${LOGSTASH_OTHER_OPTS:-}"

logstash_set(){
    sed -i "s%# path.config.*%path.config: ${LOGSTASH_BASE_DIR}/config.d%" ${LOGSTASH_CONF_DIR}/logstash.yml
	sed -i "s/-Xms.*/-Xms${JAVA_JVM_MEM}/" ${LOGSTASH_CONF_DIR}/jvm.options
	sed -i "s/-Xmx.*/-Xmx${JAVA_JVM_MEM}/" ${LOGSTASH_CONF_DIR}/jvm.options
    cat > "${LOGSTASH_CONF_EXTRA_DIR}/${LOGSTASH_CONF_FILENAME}" <<EOF
input {
  http { port => 8080 }
}
output {
  stdout {}
}
EOF

}

logstash_set
exec gosu logstash "$@" ${LOGSTASH_OTHER_OPTS}