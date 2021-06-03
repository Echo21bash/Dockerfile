FROM rootww/alpine-glibc:3.9-2.29

LABEL name="Alpine Oracle JDK10"

#JAVA_OPTS
ENV JAVA_HOME=/opt/java PATH=/opt/java/bin:$PATH

#Download and unarchive Java
RUN echo Downloading java package... && \
    mkdir /opt/{java,jar} && \
    wget -q -O /tmp/jdk.tar.gz https://repo.huaweicloud.com/java/jdk/10.0.2+13/jdk-10.0.2_linux-x64_bin.tar.gz && \
    tar zxf /tmp/jdk.tar.gz --strip-components 1 -C /opt/java && \
    sed -i '/permission java.util.PropertyPermission "java.vm.name", "read";/a\        permission java.io.FilePermission "<<ALL FILES>>","read,write,delete";' ${JAVA_HOME}/conf/security/java.policy && \
    rm -rf /tmp/jdk.tar.gz \
           /opt/java/lib/*src.zip \
           /opt/java/lib/missioncontrol \
           /opt/java/lib/visualvm \
           /opt/java/lib/*javafx* \
           /opt/java/lib/plugin.jar \
           /opt/java/lib/ext/jfxrt.jar \
           /opt/java/bin/javaws \
           /opt/java/lib/javaws.jar \
           /opt/java/lib/desktop \
           /opt/java/lib/deploy* \
           /opt/java/lib/*javafx* \
           /opt/java/lib/*jfx*

WORKDIR /opt/jar
