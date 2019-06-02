#!/bin/sh

[[ x${TRACKER_PORT} != x ]] && sed -i "s%port=22122%port=${TRACKER_PORT}%" ${FDFS_HOME}/etc/tracker.conf
[[ x${STORAGE_PORT} != x ]] && sed -i "s%port=23000%port=${STORAGE_PORT}%" ${FDFS_HOME}/etc/storage.conf && sed -i "s/storage_server_port=23000/storage_server_port=$STORAGE_PORT/" /etc/fdfs/mod_fastdfs.conf
[[ x${HTTP_PORT} != x ]] && sed -i "s%listen.*%listen    ${HTTP_PORT};%" ${NGINX_HOME}/conf/nginx.conf

[[ x${TRACKER_ADDR1} != x ]] && sed -i "s%tracker_server=0.0.0.0:22122%tracker_server=${TRACKER_ADDR1}%" ${FDFS_HOME}/etc/client.conf ${FDFS_HOME}/etc/storage.conf /etc/fdfs/mod_fastdfs.conf
[[ x${TRACKER_ADDR2} != x ]] && sed -i "s%#tracker_server=0.0.0.0:22123%tracker_server=${TRACKER_ADDR2}%" ${FDFS_HOME}/etc/client.conf ${FDFS_HOME}/etc/storage.conf /etc/fdfs/mod_fastdfs.conf
[[ x${TRACKER_ADDR3} != x ]] && sed -i "s%#tracker_server=0.0.0.0:22124%tracker_server=${TRACKER_ADDR3}%" ${FDFS_HOME}/etc/client.conf ${FDFS_HOME}/etc/storage.conf /etc/fdfs/mod_fastdfs.conf

[[ x${GROUP_NAME} != x ]] && sed -i "s%group_name=group1%group_name=${GROUP_NAME}%" ${FDFS_HOME}/etc/storage.conf /etc/fdfs/mod_fastdfs.conf

[[ "$SERVER_TYPE" =~ "tracker" || "$SERVER_TYPE" = "" ]] && ${FDFS_HOME}/bin/fdfs_trackerd ${FDFS_HOME}/etc/tracker.conf
[[ "$SERVER_TYPE" =~ "storage" || "$SERVER_TYPE" = "" ]] && ${FDFS_HOME}/bin/fdfs_storaged ${FDFS_HOME}/etc/storage.conf && /opt/nginx/sbin/nginx

tail -f /dev/null
