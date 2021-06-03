FROM alpine:3.9

ENV GLIBC_VERSION=2.29-r0 \
    GCC_LIBS_VERSION=10.1.0-1 \
    ZLIB_VERSION=1.2.11-4 \
    TZ=Asia/Shanghai

#Install bash & glibc
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --no-cache bash tzdata \
    && wget -O /etc/apk/keys/sgerrand.rsa.pub "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" \
    && wget -O glibc.apk "https://hub.fastgit.org/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && wget -O glibc-bin.apk "https://hub.fastgit.org/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && wget -O glibc-i18n.apk "https://hub.fastgit.org/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk" \
    && apk add glibc-bin.apk glibc.apk glibc-i18n.apk \
    && sed -i 's/ash/bash/g' /etc/passwd \
    && ln -snf /bin/bash /bin/sh \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*

#Install gcc-libs & zlib
RUN apk add --no-cache --virtual=build-dependencies binutils xz zstd \
    && cd /tmp \
    && mkdir /tmp/gcc \
    && wget "http://mirrors.163.com/archlinux/core/os/x86_64/gcc-libs-${GCC_LIBS_VERSION}-x86_64.pkg.tar.zst" -O gcc-libs.tar.zst \
    && zstd -d /tmp/gcc-libs.tar.zst --output-dir-flat /tmp \
    && tar -xf /tmp/gcc-libs.tar -C /tmp/gcc \
    && mv /tmp/gcc/usr/lib/libgcc* /tmp/gcc/usr/lib/libstdc++* /usr/glibc-compat/lib \
    && strip /usr/glibc-compat/lib/libgcc_s.so.* /usr/glibc-compat/lib/libstdc++.so* \
    && mkdir /tmp/zlib \
    && wget "http://mirrors.163.com/archlinux/core/os/x86_64/zlib-1%3A${ZLIB_VERSION}-x86_64.pkg.tar.xz" -O zlib.pkg.tar.xz\
    && tar xvJf zlib.pkg.tar.xz -C /tmp/zlib \
    && mv /tmp/zlib/usr/lib/libz.so* /usr/glibc-compat/lib \
    && apk del build-dependencies \
    && rm -rf /tmp/*

ENV LANG=en_US.UTF-8