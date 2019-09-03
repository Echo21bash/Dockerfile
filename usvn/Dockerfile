FROM php:5.5.30-apache

MAINTAINER hebaodanroot

ENV usvn_ver=1.0.8

RUN apt-get -y update

RUN apt-get install -y wget subversion libapache2-svn libapache2-mod-encoding sqlite3

RUN \
        cd /tmp && \
        wget "https://github.com/usvn/usvn/archive/${usvn_ver}.tar.gz" -O usvn-${usvn_ver}.tar.gz && \
        tar zxvf usvn-${usvn_ver}.tar.gz && \
	mv /tmp/${usvn_ver}/src /opt/usvn && \
        chown -R www-data:www-data /opt/usvn && \
	rm -rf /var/www/html

RUN \
        mkdir /var/lib/svn; \
        chown www-data:www-data /var/lib/svn

ADD start.sh /opt/start.sh

RUN \
  chmod -R 555 /opt/start.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 80

CMD ["/opt/start.sh"]

