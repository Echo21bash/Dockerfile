FROM centos:7.5.1804

LABEL name="CentOS7 JDK8"

ENV java_down_url='http://mirrors.linuxeye.com/jdk'

RUN java_ver=`curl -Ls ${java_down_url}/md5sum.txt | grep -oE jdk-8u.*-linux-x64.tar.gz | head -n 1` \
    && echo Downloading ${java_ver}... \
    && curl -L -o /tmp/jdk.tar.gz ${java_down_url}/${java_ver} \
    && mkdir /opt/{java,jar} \
    && tar zxf /tmp/jdk.tar.gz --strip-components 1 -C /opt/java \
    && rm -rf /tmp/jdk.tar.gz \
    && rm -rf /etc/localtime && ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -rf /opt/java/src.zip \
    && rm -rf /opt/java/javafx-src.zip

# Tomcat and Java Vars
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

WORKDIR /opt/jar
