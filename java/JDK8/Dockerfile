FROM centos:7.5.1804

LABEL name="CentOS7 Oracle JDK8"

#JAVA_OPTS
ENV JAVA_HOME=/opt/java PATH=/opt/java/bin:$PATH

#Download and unarchive Java
RUN echo Downloading java package... && \
	mkdir /opt/{java,jar} && \
    curl -L -s -o /tmp/jdk.tar.gz https://repo.huaweicloud.com/java/jdk/8u181-b13/jdk-8u181-linux-x64.tar.gz && \
    tar zxf /tmp/jdk.tar.gz --strip-components 1 -C /opt/java && \
    ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i '/permission java.util.PropertyPermission "java.vm.name", "read";/a\        permission java.io.FilePermission "<<ALL FILES>>","read,write,delete";' ${JAVA_HOME}/jre/lib/security/java.policy && \
    rm -rf /tmp/jdk.tar.gz \
           /opt/java/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so

WORKDIR /opt/jar
