FROM centos:7.5.1804

LABEL name="CentOS7 JDK8"

#JAVA_OPTS
ENV JAVA_HOME=/opt/java \
    PATH=/opt/java/bin:$PATH \
    JAVA_OPTS="-Xms1024m \
    -Xmx1024m \
    -Xmn384m \
    -Xss512k \
    -XX:SurvivorRatio=10 \
    -XX:MetaspaceSize=128m \
    -XX:MaxMetaspaceSize=196m \
    -XX:+UseConcMarkSweepGC \
    -XX:+CMSScavengeBeforeRemark \
    -XX:+CMSParallelRemarkEnabled \
    -XX:+AggressiveOpts"

RUN echo Downloading jdk-8u181-linux-x64.tar.gz... \
    && java_down_url='https://repo.huaweicloud.com/java/jdk/8u181-b13/jdk-8u181-linux-x64.tar.gz' \
    && curl -L -s -o /tmp/jdk.tar.gz ${java_down_url} \
    && mkdir /opt/{java,jar} \
    && tar zxf /tmp/jdk.tar.gz --strip-components 1 -C /opt/java \
    && rm -rf /tmp/jdk.tar.gz \
    && rm -rf /etc/localtime && ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -rf /opt/java/*src.zip \
              /opt/java/lib/missioncontrol \
              /opt/java/lib/visualvm \
              /opt/java/lib/*javafx* \
              /opt/java/jre/plugin \
              /opt/java/jre/bin/javaws \
              /opt/java/jre/bin/jjs \
              /opt/java/jre/bin/orbd \
              /opt/java/jre/bin/pack200 \
              /opt/java/jre/bin/policytool \
              /opt/java/jre/bin/rmid \
              /opt/java/jre/bin/rmiregistry \
              /opt/java/jre/bin/servertool \
              /opt/java/jre/bin/tnameserv \
              /opt/java/jre/bin/unpack200 \
              /opt/java/jre/lib/javaws.jar \
              /opt/java/jre/lib/deploy* \
              /opt/java/jre/lib/desktop \
              /opt/java/jre/lib/*javafx* \
              /opt/java/jre/lib/*jfx* \
              /opt/java/jre/lib/amd64/libdecora_sse.so \
              /opt/java/jre/lib/amd64/libprism_*.so \
              /opt/java/jre/lib/amd64/libfxplugins.so \
              /opt/java/jre/lib/amd64/libglass.so \
              /opt/java/jre/lib/amd64/libgstreamer-lite.so \
              /opt/java/jre/lib/amd64/libjavafx*.so \
              /opt/java/jre/lib/amd64/libjfx*.so \
              /opt/java/jre/lib/ext/jfxrt.jar \
              /opt/java/jre/lib/ext/nashorn.jar \
              /opt/java/jre/lib/oblique-fonts \
              /opt/java/jre/lib/plugin.jar

WORKDIR /opt/jar
