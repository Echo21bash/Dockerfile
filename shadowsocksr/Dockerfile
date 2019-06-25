FROM alpine

ENV SERVER_ADDR     0.0.0.0 \
    SERVER_PORT     51348 \
    PASSWORD        psw \
    METHOD          aes-128-ctr \
    PROTOCOL        auth_aes128_md5 \
    PROTOCOLPARAM   32 \
    OBFS            tls1.2_ticket_auth_compatible \
    TIMEOUT         300 \
    DNS_ADDR        119.29.29.29 \
    DNS_ADDR_2      8.8.8.8

RUN apk --no-cache add python \
    libsodium \
    && curl -L -o /tmp/shadowsocksr-3.2.2.tar.gz https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz \
	&& tar zxf /tmp/shadowsocksr-3.2.2.tar.gz -C /tmp \
	&& mv /tmp/shadowsocksr-3.2.2/shadowsocks /usr/local/ \
	&& rm -fr /tmp/shadowsocksr-3.2.2 \
	&& rm -f /tmp/shadowsocksr-3.2.2.tar.gz

WORKDIR /usr/local/shadowsocks

EXPOSE $SERVER_PORT

CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM
    
