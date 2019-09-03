FROM php:5.5.30-apache

MAINTAINER hebaodanroot

RUN apt-get -y update

RUN apt-get install -y wget subversion libapache2-svn libapache2-mod-encoding sqlite3

RUN \
        cd /usr/local/src && \
        wget "https://github.com/usvn/usvn/archive/1.0.7.tar.gz" -O usvn-1.0.7.tar.gz && \
        tar zxvf usvn-1.0.7.tar.gz && \
        chown -R www-data:www-data /usr/local/src/usvn-1.0.7 && \
	rm -rf /var/www/html

RUN \
        mkdir /var/lib/svn; \
        chown www-data:www-data /var/lib/svn

ADD start.sh /opt/start.sh

RUN \
  chmod -R 555 /opt/start.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USVN_SUBDIR ""

EXPOSE 80

VOLUME /var/lib/svn

CMD ["/opt/start.sh"]

