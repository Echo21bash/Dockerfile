FROM alpine

ENV SERVER_ADDR=0.0.0.0 \
    SERVER_PORT=8388 \
    PASSWORD=passw0ord \
    METHOD=aes-128-ctr \
    PROTOCOL=auth_aes128_md5 \
    PROTOCOLPARAM=32 \
    OBFS=http_simple_compatible \
    TIMEOUT=300 \
    DNS_ADDR=8.8.8.8

ADD docker-entrypoint.sh /opt

RUN apk --no-cache add python \
    libsodium \
    curl \
    && curl -L -o /tmp/shadowsocksr-3.2.2.tar.gz https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz \
    && tar zxf /tmp/shadowsocksr-3.2.2.tar.gz -C /tmp \
    && mv /tmp/shadowsocksr-3.2.2/shadowsocks /usr/local/ \
    && chmod +x /opt/docker-entrypoint.sh \
    && rm -rf /tmp/shadowsocksr-3.2.2 \
    && rm -f /tmp/shadowsocksr-3.2.2.tar.gz

ADD dns.conf /usr/local/shadowsocks

WORKDIR /usr/local/shadowsocks

EXPOSE $SERVER_PORT

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
