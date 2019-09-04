# usvn
一个使用docker提供subversion和usvn（web管理）的容器。  
容器中的文件与主机端隔离。如果需要保存永久文件，请使用-v选项将主机目录装载到以下位置。
+ /opt/usvn/files

## 使用


服务器IP 192.168.1.100  
访问url http://192.168.1.100/usvn  
持久目录 /opt/usvn/files

docker run -d
 --name usvn
 -v /opt/usvn/files:/opt/usvn/files:rw
 -e USVN_SUBDIR=/usvn
 -p 80:80
 rootww/usvn
