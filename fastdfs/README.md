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
        docker run --network=host --name fdfs -d -v /data/fastdfs:/opt/fdfs/data -p 8080:8080 -p 22122:22122 -p 2300:2300 -e TRACKER_ADDR1=192.168.1.2:22122  docker.io/rootww/fastdfs:latest

    
    3、集群模式(多台机器ip192.168.1.2 192.168.1.3)
        以tracker模式启动
        分别在两台服务器运行
        docker run --network=host --name fdfs_tracker -d -v /data/fastdfs:/opt/fdfs/data -p 22122:22122 -e SERVER_TYPE=tracker docker.io/rootww/fastdfs:latest
    
        以storage模式启动
        分别在两台服务器运行
        docker run --network=host --name fdfs_storage -d -v /data/fastdfs:/opt/fdfs/data -p 8080:8080 -p 23000:23000 -e SERVER_TYPE=storage -e TRACKER_ADDR1=192.168.1.2:22122 -e TRACKER_ADDR2=192.168.1.3:22122 docker.io/rootww/fastdfs:latest
部署注意事项
----------
    1、分布式部署时同组storage端口号必须一致
