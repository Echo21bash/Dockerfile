关于该Dockerfile的使用说明
===
    1、基于轻量级alpine制作
    2、源码来自https://github.com/shadowsocksrr/shadowsocksr
以server方式启动
----
    docker run --name ssr-server -d -p 8888:8888 -e SERVER_TYPE=server rootww/ssr:latest
以client方式启动
----
    docker run --name ssr-client -d -p 1080:1080 -v shadowsocksr.json:/etc/shadowsocksr.json -e SERVER_TYPE=client rootww/ssr:latest
