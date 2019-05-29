FROM centos:7.5.1804

LABEL name="CentOS7 FASTDFS"

ENV FDFS_DOWN_URL='https://github.com/happyfish100/fastdfs/archive/master.tar.gz' \
    FDFSCOMM_DOWN_URL='https://github.com/happyfish100/libfastcommon/archive/master.tar.gz' \
    NGINX_DOWN_URL='http://nginx.org/download/nginx-1.15.0.tar.gz' \
    NGINX_FDFS_DOWN_URL='https://github.com/happyfish100/fastdfs-nginx-module/archive/master.tar.gz'

RUN echo Downloading fastdfs,nginx... \
    && curl -L -o /tmp/fdfs.tar.gz ${FDFS_DOWN_URL} \
    && curl -L -o /tmp/fdfscomm.tar.gz ${FDFSCOMM_DOWN_URL} \
    && curl -L -o /tmp/nginx.tar.gz ${NGINX_DOWN_URL} \
    && curl -L -o /tmp/nginx-module.tar.gz ${NGINX_FDFS_DOWN_URL} \
    && mkdir -p /opt/{fdfs/data,nginx} \
    && yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel pcre pcre-devel \
    && yum clean all \
    && cd /tmp \
    && tar zxf /tmp/fdfs.tar.gz \
    && tar zxf /tmp/fdfscomm.tar.gz \
    && tar zxf /tmp/nginx.tar.gz \
    && tar zxf /tmp/nginx-module.tar.gz \
    && cd  /tmp/libfastcommon-master \
    && sed -i "/^TARGET_PREFIX=$DESTDIR/i\DESTDIR=/opt/fdfs" ./make.sh \
    && sed -i 's#TARGET_PREFIX=.*#TARGET_PREFIX=$DESTDIR#' ./make.sh \
    && ./make.sh && ./make.sh install \
    && ln -sfn /opt/fdfs/include/fastcommon /usr/include \
    && ln -sfn /opt/fdfs/lib64/libfastcommon.so /usr/lib/libfastcommon.so \
    && ln -sfn /opt/fdfs/lib64/libfastcommon.so /usr/lib64/libfastcommon.so \
    && cd /tmp/fastdfs-master \
    && sed -i "/^TARGET_PREFIX=$DESTDIR/i\DESTDIR=/opt/fdfs" ./make.sh \
    && sed -i 's#TARGET_PREFIX=.*#TARGET_PREFIX=$DESTDIR#' ./make.sh \
    && sed -i 's#TARGET_CONF_PATH=.*#TARGET_CONF_PATH=$DESTDIR/etc#' ./make.sh \
    && sed -i 's#TARGET_INIT_PATH=.*#TARGET_INIT_PATH=$DESTDIR/etc/init.d#' ./make.sh \
    && ./make.sh && ./make.sh install \
    && ln -sfn /opt/fdfs/include/fastdfs /usr/include \
    && ln -sfn /opt/fdfs/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so \
    && ln -sfn /opt/fdfs/lib64/libfdfsclient.so /usr/lib64/libfdfsclient.so \
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

RUN echo configuring fastdfs nginx... \
    && cp /opt/fdfs/etc/tracker.conf.sample /opt/fdfs/etc/tracker.conf \
    && cp /opt/fdfs/etc/storage.conf.sample /opt/fdfs/etc/storage.conf \
    && cp /opt/fdfs/etc/client.conf.sample /opt/fdfs/etc/client.conf \
    && cp /tmp/fastdfs-master/conf/http.conf /etc/fdfs \
    && cp /tmp/fastdfs-master/conf/mime.types /etc/fdfs \
    && cp /tmp/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs \
    && sed -i "s#base_path=.*#base_path=${file_dir}#" ${home_dir}/etc/client.conf \
    && sed -i "s%tracker_server=.*%tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22122%" /opt/fdfs/etc/client.conf \
    && sed -i "s#port=23000#port=${STORAGE_PORT:-2300}#" /opt/fdfs/etc/storage.conf \
    && sed -i "s#base_path=.*#base_path=/opt/fdfs/data#" /opt/fdfs/etc/storage.conf \
    && sed -i "s#store_path0=.*#store_path0=/opt/fdfs/data#" /opt/fdfs/etc/storage.conf \
    && sed -i "s%tracker_server=.*%tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22122%" /opt/fdfs/etc/storage.conf \
    && sed -i "s#base_path=.*#base_path=/opt/fdfs/data#" /opt/fdfs/etc/tracker.conf \
    && sed -i "s#base_path=.*#base_path=/opt/fdfs/data#" /etc/fdfs/mod_fastdfs.conf \
    && sed -i "s%tracker_server=.*%tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22122\n#tracker_server=0.0.0.0:22122%" /etc/fdfs/mod_fastdfs.conf

RUN echo '#!/bin/sh'>/opt/docker-entrypoint.sh \
    && echo '[[ x${TRACKER_ADDR1} != 'x' ]] && sed -i "s%tracker_server=0.0.0.0.*%tracker_server=${TRACKER_ADDR1}%" /opt/fdfs/etc/client.conf /opt/fdfs/etc/storage.conf /etc/fdfs/mod_fastdfs.conf'>>/opt/docker-entrypoint.sh \
    && echo '[[ x${TRACKER_ADDR2} != 'x' ]] && sed -i "s%#tracker_server=0.0.0.0.*%tracker_server=${TRACKER_ADDR2}%" /opt/fdfs/etc/client.conf /opt/fdfs/etc/storage.conf /etc/fdfs/mod_fastdfs.conf'>>/opt/docker-entrypoint.sh \
    && echo '[[ x${TRACKER_ADDR3} != 'x' ]] && sed -i "s%#tracker_server=0.0.0.0.*%tracker_server=${TRACKER_ADDR3}%" /opt/fdfs/etc/client.conf /opt/fdfs/etc/storage.conf /etc/fdfs/mod_fastdfs.conf'>>/opt/docker-entrypoint.sh \
    && echo '[[ "$SERVER_TYPE" =~ "tracker" || "$SERVER_TYPE" = "" ]] && /opt/fdfs/bin/fdfs_trackerd /opt/fdfs/etc/tracker.conf'>>/opt/docker-entrypoint.sh \
    && echo '[[ "$SERVER_TYPE" =~ "storage" || "$SERVER_TYPE" = "" ]] && /opt/fdfs/bin/fdfs_storaged /opt/fdfs/etc/storage.conf'>>/opt/docker-entrypoint.sh \
    && echo '/opt/nginx/sbin/nginx'>>/opt/docker-entrypoint.sh \
    && echo 'tail -f /dev/null'>>/opt/docker-entrypoint.sh \
    && chmod +x /opt/docker-entrypoint.sh

EXPOSE 22122 ${STORAGE_PORT} 80

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
