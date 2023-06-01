FROM alpine:3.9

ENV GLIBC_VERSION=2.29-r0 \
    GCC_LIBS_VERSION=11.1.0-1 \
    ZLIB_VERSION=1.2.11-4 \
    TZ=Asia/Shanghai

#Install bash & glibc
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --no-cache bash tzdata \
    && wget -O /etc/apk/keys/sgerrand.rsa.pub "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" \
    && wget -O glibc.apk "https://ghproxy.com/https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && wget -O glibc-bin.apk "https://ghproxy.com/https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && wget -O glibc-i18n.apk "https://ghproxy.com/https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk" \
    && apk add glibc-bin.apk glibc.apk glibc-i18n.apk \
    && sed -i 's/ash/bash/g' /etc/passwd \
    && ln -snf /bin/bash /bin/sh \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf glibc.apk glibc-bin.apk glibc-i18n.apk /var/cache/apk/*

ENV LANG=en_US.UTF-8