关于该Dockerfile的使用说明
===
    1、基于轻量级alpine制作
    2、源码来自https://github.com/shadowsocksrr/shadowsocksr
以server方式启动
----
    docker run -d -e SERVER_TYPE=server rootww/ssr:latest
以client方式启动
----
    docker run -d -e SERVER_TYPE=client rootww/ssr:latest
