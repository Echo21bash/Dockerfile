#!/bin/sh

if [[ "$SERVER_TYPE" = "server" || "$SERVER_TYPE" = "" ]];then
	sed -i "s/\"listen_port\": 12475/\"listen_port\": ${SERVER_PORT}/" /opt/ssr-n/config.json
	sed -i "s/\"password\".*/\"password\": \"${PASSWORD}\",/" /opt/ssr-n/config.json
	sed -i "s/\"method\".*/\"method\": \"${METHOD}\",/" /opt/ssr-n/config.json
	sed -i "s/\"protocol\".*/\"protocol\": \"${PROTOCOL}\",/" /opt/ssr-n/config.json
	sed -i "s/\"obfs\".*/\"obfs\": \"${OBFS}\",/" /opt/ssr-n/config.json
	/opt/ssr-n/ssr-server -c /opt/ssr-n/config.json
fi

if [[ "$SERVER_TYPE" = "client" ]];then
	sed -i "s/\"server\".*/\"server\": \"${SERVER_IP}\",/" /opt/ssr-n/config.json
	sed -i "s/\"server_port\".*/\"server_port\": ${SERVER_PORT},/" /opt/ssr-n/config.json
	sed -i "s/\"password\".*/\"password\": \"${PASSWORD}\",/" /opt/ssr-n/config.json
	sed -i "s/\"method\".*/\"method\": \"${METHOD}\",/" /opt/ssr-n/config.json
	sed -i "s/\"protocol\".*/\"protocol\": \"${PROTOCOL}\",/" /opt/ssr-n/config.json
	sed -i "s/\"obfs\".*/\"obfs\": \"${OBFS}\",/" /opt/ssr-n/config.json
	sed -i "s/\"obfs_param\".*/\"obfs_param\": \"${OBFS_PARAM}\",/" /opt/ssr-n/config.json
	/opt/ssr-n/ssr-client -c /opt/ssr-n/config.json
fi
