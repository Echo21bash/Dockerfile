FROM php:7.3-apache

MAINTAINER echo21bash

ENV usvn_ver=1.0.10 \
    USVN_SUBDIR=

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get -y update

RUN apt-get install -y subversion libapache2-mod-svn libapache2-mod-encoding sqlite3

###add usvn

ADD https://ghproxy.com/https://github.com/usvn/usvn/archive/${usvn_ver}.tar.gz /usr/local/src/

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN cd /usr/local/src/ && \
    tar zxf ${usvn_ver}.tar.gz -C /var/www/html/ && \
    mv /var/www/html/usvn-${usvn_ver}/src/* /var/www/html && \
    mkdir -p /var/lib/svn/config /var/lib/svn/files && \
    chown -R 33.33 /var/lib/svn /var/www/html && \ 
    chmod +x /usr/local/bin/docker-entrypoint.sh

###install ldap
RUN apt-get install libldap2-dev -y && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-install ldap

###clean tmp file
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /usr/local/src/${usvn_ver}.tar.gz /var/www/html/usvn-${usvn_ver}/

EXPOSE 80

VOLUME /var/lib/svn

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]

