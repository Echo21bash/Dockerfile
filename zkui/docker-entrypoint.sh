#!/bin/sh

ZK_SERVER=${ZK_SERVER:-"localhost:2181"}

USER_SET=${USER_SET:-"{\"users\": [{ \"username\":\"admin\" , \"password\":\"manager\",\"role\": \"ADMIN\" \},{ \"username\":\"appconfig\" , \"password\":\"appconfig\",\"role\": \"USER\" \}]\}"}
LOGIN_MESSAGE=${LOGIN_MESSAGE:-"Please login using admin/manager or appconfig/appconfig."}

sed -i "s%^zkServer=.*%zkServer=$ZK_SERVER%" /opt/jar/config.cfg
sed -i "s%^userSet = .*%userSet = $USER_SET%" /opt/jar/config.cfg
sed -i "s%^loginMessage=.*%loginMessage=$LOGIN_MESSAGE%" /opt/jar/config.cfg

echo "Starting zkui with server $ZK_SERVER"

exec java -jar /opt/jar/zkui.jar
