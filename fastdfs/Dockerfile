FROM centos:7.5.1804

LABEL name="CentOS7 FASTDFS"

ENV FDFS_DOWN_URL='https://github.com/happyfish100/fastdfs/archive/master.tar.gz' \
    FDFSCOMM_DOWN_URL='https://github.com/happyfish100/libfastcommon/archive/master.tar.gz' \
    NGINX_DOWN_URL='http://nginx.org/download/nginx-1.15.0.tar.gz' \
    NGINX_FDFS_DOWN_URL='https://github.com/happyfish100/fastdfs-nginx-module/archive/master.tar.gz' \
    NGINX_HOME='/opt/nginx' \
    FDFS_HOME='/opt/fdfs'
ENV PATH=$PATH:${NGINX_HOME}/sbin:${FDFS_HOME}/bin

RUN echo Downloading fastdfs,nginx... \
    && curl -L -o /tmp/fdfs.tar.gz ${FDFS_DOWN_URL} \
    && curl -L -o /tmp/fdfscomm.tar.gz ${FDFSCOMM_DOWN_URL} \
    && curl -L -o /tmp/nginx.tar.gz ${NGINX_DOWN_URL} \
    && curl -L -o /tmp/nginx-module.tar.gz ${NGINX_FDFS_DOWN_URL} \
    && mkdir -p ${NGINX_HOME} ${FDFS_HOME}/data \
    && yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel pcre pcre-devel \
    && yum clean all \
    && cd /tmp \
    && tar zxf /tmp/fdfs.tar.gz \
    && tar zxf /tmp/fdfscomm.tar.gz \
    && tar zxf /tmp/nginx.tar.gz \
    && tar zxf /tmp/nginx-module.tar.gz \
    && cd  /tmp/libfastcommon-master \
    && sed -i "/^TARGET_PREFIX=$DESTDIR/i\DESTDIR=${FDFS_HOME}" ./make.sh \
    && sed -i 's#TARGET_PREFIX=.*#TARGET_PREFIX=$DESTDIR#' ./make.sh \
    && ./make.sh && ./make.sh install \
    && ln -sfn ${FDFS_HOME}/include/fastcommon /usr/include \
    && ln -sfn ${FDFS_HOME}/lib64/libfastcommon.so /usr/lib/libfastcommon.so \
    && ln -sfn ${FDFS_HOME}/lib64/libfastcommon.so /usr/lib64/libfastcommon.so \
    && cd /tmp/fastdfs-master \
    && sed -i "/^TARGET_PREFIX=$DESTDIR/i\DESTDIR=${FDFS_HOME}" ./make.sh \
    && sed -i 's#TARGET_PREFIX=.*#TARGET_PREFIX=$DESTDIR#' ./make.sh \
    && sed -i 's#TARGET_CONF_PATH=.*#TARGET_CONF_PATH=$DESTDIR/etc#' ./make.sh \
    && sed -i 's#TARGET_INIT_PATH=.*#TARGET_INIT_PATH=$DESTDIR/etc/init.d#' ./make.sh \
    && ./make.sh && ./make.sh install \
    && ln -sfn ${FDFS_HOME}/include/fastdfs /usr/include \
    && ln -sfn ${FDFS_HOME}/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so \
    && ln -sfn ${FDFS_HOME}/lib64/libfdfsclient.so /usr/lib64/libfdfsclient.so \
    && cd /tmp/nginx-1.15.0 \
    && ./configure --prefix=/opt/nginx \
       --with-http_stub_status_module \
       --with-http_ssl_module \
       --with-http_gzip_static_module \
       --with-pcre \
       --with-stream \
       --with-stream_ssl_module \
       --add-module=../fastdfs-nginx-module-master/src \
    && make && make install \
    && rm -rf /etc/localtime && ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD docker-entrypoint.sh /opt/
ADD nginx.conf ${NGINX_HOME}/conf/

RUN echo configuring fastdfs nginx... \
    && cp ${FDFS_HOME}/etc/tracker.conf.sample ${FDFS_HOME}/etc/tracker.conf \
    && cp ${FDFS_HOME}/etc/storage.conf.sample ${FDFS_HOME}/etc/storage.conf \
    && cp ${FDFS_HOME}/etc/client.conf.sample ${FDFS_HOME}/etc/client.conf \
    && cp /tmp/fastdfs-master/conf/http.conf /etc/fdfs \
    && cp /tmp/fastdfs-master/conf/mime.types /etc/fdfs \
    && cp /tmp/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs \
    && sed -i "s#base_path=.*#base_path=${FDFS_HOME}/data#" ${FDFS_HOME}/etc/client.conf \
    && sed -i "s%tracker_server=.*%tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22123\n#tracker_server=0.0.0.0:22124%" ${FDFS_HOME}/etc/client.conf \
    && sed -i "s#port=23000#port=${STORAGE_PORT:-23000}#" ${FDFS_HOME}/etc/storage.conf \
    && sed -i "s#base_path=.*#base_path=${FDFS_HOME}/data#" ${FDFS_HOME}/etc/storage.conf \
    && sed -i "s#store_path0=.*#store_path0=${FDFS_HOME}/data#" ${FDFS_HOME}/etc/storage.conf \
    && sed -i "s%tracker_server=.*%tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22123\n#tracker_server=0.0.0.0:22124%" ${FDFS_HOME}/etc/storage.conf \
    && sed -i "s#base_path=.*#base_path=${FDFS_HOME}/data#" ${FDFS_HOME}/etc/tracker.conf \
    && sed -i "s#base_path=.*#base_path=${FDFS_HOME}/data#" /etc/fdfs/mod_fastdfs.conf \
    && sed -i "s%tracker_server=.*%tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22123\n#tracker_server=0.0.0.0:22124%" /etc/fdfs/mod_fastdfs.conf \
    && chmod +x /opt/docker-entrypoint.sh \
    && rm -rf /tmp/*

WORKDIR /opt

EXPOSE 22122 ${STORAGE_PORT:-23000} 80

ENTRYPOINT ["docker-entrypoint.sh"]
