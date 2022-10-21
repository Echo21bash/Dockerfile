关于该Dockerfile的使用说明
===
    1、基于轻量级alpine制作
    2、源码来自https://github.com/ShadowsocksR-Live/shadowsocksr-native
以server方式启动
----
    docker run --name ssr-server -itd -p 8388:8388 -e SERVER_TYPE=server rootww/shadowsocksr-n:v0.9.3
    可以通过变量修改默认配置默认值如下
    SERVER_PORT=8388
    PASSWORD=passw0ord
    METHOD=aes-128-ctr
    PROTOCOL=auth_aes128_md5
    OBFS=http_simple
以client方式启动
----
    docker run --name ssr-client -itd -p 1080:1080 -e SERVER_TYPE=client -e SERVER_IP=x.x.x.x -e SERVER_PORT=8388 -e PASSWORD='passw0ord' -e METHOD='aes-128-ctr' -e PROTOCOL='auth_aes128_md5' -e OBFS='http_simple' -e OBFS_PARAM='baidu.com' rootww/shadowsocksr-n:v0.9.3
    
    linux 配置代理
    #export proxy="socks5://172.18.8.114:1080"
    #export https_proxy=$proxy
    #export http_proxy=$proxy
    #export no_proxy="localhost,172.18.8.114,127.0.0.1, ::1"
