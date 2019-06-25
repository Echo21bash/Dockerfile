FROM alpine:3.6

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
    wget
    
