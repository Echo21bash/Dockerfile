#!/bin/sh

[[ "$SERVER_TYPE" = "server" || "$SERVER_TYPE" = "" ]] && python /usr/local/shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM
[[ "$SERVER_TYPE" = "client" ]] && python /usr/local/shadowsocks/local.py -c /etc/shadowsocksr.json
