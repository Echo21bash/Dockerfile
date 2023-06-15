FROM amd64/ubuntu:23.04

ARG VERSION

ARG DBTYPE

ADD https://ghproxy.com/https://github.com/wal-g/wal-g/releases/download/v${VERSION}/wal-g-${DBTYPE}-ubuntu-20.04-amd64 /usr/bin/wal-g

RUN chmod +x /usr/bin/wal-g && \
    sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get update && \
    apt-get clean all

CMD ["wal-g --help"]