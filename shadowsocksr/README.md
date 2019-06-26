关于该Dockerfile的使用说明
===
    1、基于轻量级alpine制作
    2、源码来自https://github.com/shadowsocksrr/shadowsocksr
以server方式启动
----
    docker run --name ssr-server -d -p 8388:8388 -e SERVER_TYPE=server rootww/shadowsocksr:latest
    可以通过变量修改默认配置默认值如下
    SERVER_PORT=8388
    PASSWORD=passw0ord
    METHOD=aes-128-ctr
    PROTOCOL=auth_aes128_md5
    PROTOCOLPARAM=32
    OBFS=http_simple_compatible
    TIMEOUT=300
以client方式启动
----
    docker run --name ssr-client -d -p 1080:1080 -v shadowsocksr.json:/etc/shadowsocksr.json -e SERVER_TYPE=client rootww/shadowsocksr:latest
    客户端启动需要JSON格式的配置文件
    
