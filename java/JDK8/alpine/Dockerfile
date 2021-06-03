FROM rootww/alpine-glibc:3.9-2.29

LABEL name="Alpine Oracle JDK8"

#JAVA_OPTS
ENV JAVA_HOME=/opt/java PATH=/opt/java/bin:$PATH

#Download and unarchive Java
RUN echo Downloading java package... && \
    mkdir /opt/{java,jar} && \
    wget -q -O /tmp/jdk.tar.gz http://repo.huaweicloud.com/java/jdk/8u181-b13/jdk-8u181-linux-x64.tar.gz && \
    tar zxf /tmp/jdk.tar.gz --strip-components 1 -C /opt/java && \
    sed -i '/permission java.util.PropertyPermission "java.vm.name", "read";/a\        permission java.io.FilePermission "<<ALL FILES>>","read,write,delete";' ${JAVA_HOME}/jre/lib/security/java.policy && \
    rm -rf /tmp/jdk.tar.gz \
           /opt/java/*src.zip \
           /opt/java/lib/missioncontrol \
           /opt/java/lib/visualvm \
           /opt/java/lib/*javafx* \
           /opt/java/jre/lib/plugin.jar \
           /opt/java/jre/lib/ext/jfxrt.jar \
           /opt/java/jre/bin/javaws \
           /opt/java/jre/lib/javaws.jar \
           /opt/java/jre/lib/desktop \
           /opt/java/jre/plugin \
           /opt/java/jre/lib/deploy* \
           /opt/java/jre/lib/*javafx* \
           /opt/java/jre/lib/*jfx* \
           /opt/java/jre/lib/amd64/libdecora_sse.so \
           /opt/java/jre/lib/amd64/libprism_*.so \
           /opt/java/jre/lib/amd64/libfxplugins.so \
           /opt/java/jre/lib/amd64/libglass.so \
           /opt/java/jre/lib/amd64/libgstreamer-lite.so \
           /opt/java/jre/lib/amd64/libjavafx*.so \
           /opt/java/jre/lib/amd64/libjfx*.so

WORKDIR /opt/jar
