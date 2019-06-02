关于该Dockerfile文件的说明
-------
    1、该镜像基于CentOS7制作
    2、基于最新版的fastdfs编译
    3、集成Nginx_fastdfs模块提供http服务
关于该容器的使用说明
-------
    1、获取镜像
        docker pull docker.io/rootww/fastdfs:latest
    2、单机模式(ip 192.168.1.2)
        docker run --network=host --name fdfs -d -v /data/fastdfs:/opt/fdfs/data -e TRACKER_ADDR1=192.168.1.2:22122  docker.io/rootww/fastdfs:latest

    
    3、集群模式(多台机器ip192.168.1.2 192.168.1.3)
        以tracker模式启动
        分别在两台服务器运行
        docker run --network=host --name fdfs_tracker -d -v /data/fastdfs:/opt/fdfs/data -e SERVER_TYPE=tracker docker.io/rootww/fastdfs:latest
    
        以storage模式启动
        分别在两台服务器运行
        docker run --network=host --name fdfs_storage -d -v /data/fastdfs:/opt/fdfs/data -e SERVER_TYPE=storage -e TRACKER_ADDR1=192.168.1.2:22122 -e TRACKER_ADDR2=192.168.1.3:22122 docker.io/rootww/fastdfs:latest
部署注意事项
----------
    1、分布式部署时同组storage端口号必须一致
    2、分布式部署时同组http端口也必须一致，可通过HTTP_PORT变量传入，默认值为8080
    3、以tracker启动时使用SERVER_TYPE=tracker指定，端口默认为22122，可通过TRSCKET_PORT变量传入
    4、以storage启动时使用SERVER_TYPE=storage指定，端口默认为23000，并且必须指定tracker的地址，格式为ip：port，使用TRACKER_ADDR1、TRACKER_ADDR2、TRACKER_ADDR3这三个变量传入，根据自己实际情况设置
    5、以storage启动时还可使用GROUP_NAME指定组名
