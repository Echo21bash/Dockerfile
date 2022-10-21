FROM rootww/alpine-glibc:3.9-2.29

ENV VER_NUM=0.9.3 \
    SERVER_PORT=8388 \
    PASSWORD=passw0ord \
    METHOD=aes-128-ctr \
    PROTOCOL=auth_aes128_md5 \
    OBFS=http_simple

ADD docker-entrypoint.sh /opt

RUN apk --no-cache add libsodium json-c libuv mbedtls \
    && wget -O /tmp/ssr-native-linux-x64.zip https://ghproxy.com/https://github.com/ShadowsocksR-Live/shadowsocksr-native/releases/download/${VER_NUM}/ssr-native-linux-x64.zip \
    && mkdir -p /opt/ssr-n \
    && unzip /tmp/ssr-native-linux-x64.zip -d /opt/ssr-n \
    && chmod +x /opt/docker-entrypoint.sh \
    && rm -rf /etc/localtime \
    && ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -f /tmp/ssr-native-linux-x64.zip


WORKDIR /opt/ssr-n

EXPOSE $SERVER_PORT

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
