FROM centos:7.5.1804

LABEL name="CentOS7 JDK8 Tomcat8.5"

ENV java_down_url='http://mirrors.linuxeye.com/jdk' \
    tomcat_down_url='http://mirrors.ustc.edu.cn/apache/tomcat/tomcat-8'

RUN java_ver=`curl -Ls ${java_down_url}/md5sum.txt | grep -oE jdk-8u.*-linux-x64.tar.gz | head -n 1` \
    && echo Downloading ${java_ver}... \
    && curl -L -o /tmp/jdk.tar.gz ${java_down_url}/${java_ver} \
    && mkdir /opt/{java,tomcat} \
    && tar zxf /tmp/jdk.tar.gz --strip-components 1 -C /opt/java \
    && tomcat_ver=`curl -Ls ${tomcat_down_url} | grep -oE "8.5.[0-9]{1,2}" | head -n 1` \
    && echo Downloading apache-tomcat-${tomcat_ver}.tar.gz... \
    && curl -L -o /tmp/tomcat.tar.gz ${tomcat_down_url}/v${tomcat_ver}/bin/apache-tomcat-${tomcat_ver}.tar.gz \
    && tar zxf /tmp/tomcat.tar.gz --strip-components 1 -C /opt/tomcat \
    && rm -rf /tmp/jdk.tar.gz /tmp/tomcat.tar.gz \
    && rm -rf /etc/localtime && ln -sfn /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Tomcat and Java Vars
ENV JAVA_HOME=/opt/java \
    CATALINA_HOME=/opt/tomcat \
    PATH=/opt/java/bin:$PATH \
    JAVA_OPTS="-Xms1024m \
    -Xmx1024m \
    -Xmn384m \
    -Xss512k \
    -XX:SurvivorRatio=10 \
    -XX:MetaspaceSize=128m \
    -XX:MaxMetaspaceSize=156m \
    -XX:+UseConcMarkSweepGC \
    -XX:+CMSScavengeBeforeRemark \
    -XX:+CMSParallelRemarkEnabled \
    -XX:+AggressiveOpts"

RUN echo Configuring tomcat... \
    && echo '               maxThreads="600"'>/tmp/tmp.server.xml \
    && echo '               minSpareThreads="100"'>>/tmp/tmp.server.xml \
    && echo '               acceptorThreadCount="4"'>>/tmp/tmp.server.xml \
    && echo '               acceptCount="500"'>>/tmp/tmp.server.xml \
    && echo '               enableLookups="false"'>>/tmp/tmp.server.xml \
    && echo '               URIEncoding="UTF-8" />'>>/tmp/tmp.server.xml \
    && sed -i '/<Connector port="8080" protocol="HTTP\/1.1"/,/redirectPort="8443" \/>/s/redirectPort="8443" \/>/redirectPort="8443"/' /opt/tomcat/conf/server.xml \
    && sed -i '/^               redirectPort="8443"$/r /tmp/tmp.server.xml' /opt/tomcat/conf/server.xml \
    && sed -i 's/<Server port="8005"/<Server port="-1"/' /opt/tomcat/conf/server.xml \
    && sed -i 's#<Connector port="8009".*#<!-- <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" /> -->#' /opt/tomcat/conf/server.xml \
    && rm -rf /tmp/tmp.server.xml

WORKDIR $CATALINA_HOME

EXPOSE 8080

CMD ["bin/catalina.sh","run"]
