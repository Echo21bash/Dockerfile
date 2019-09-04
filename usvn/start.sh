#!/bin/sh

cd /
# apache设置
cat << EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /opt/usvn
        <Directory /opt/usvn>
                AllowOverride all
                Options -MultiViews
                Order Deny,Allow
                Allow from all
                Require all granted
        </Directory>
        ErrorLog /var/log/apache2/error.log
        CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF

cat << EOF > /etc/apache2/mods-enabled/dav_svn.conf
<Location ${USVN_SUBDIR}/svn/>
	ErrorDocument 404 default
	DAV svn
	Require valid-user
	SVNParentPath /opt/usvn/files/svn
	SVNListParentPath off
	AuthType Basic
	AuthName "USVN"
	AuthUserFile /opt/usvn/files/htpasswd
	AuthzSVNAccessFile /opt/usvn/files/authz
</Location>
EOF

cat << EOF > /opt/usvn/public/.htaccess
<Files *.ini>
Order Allow,Deny
Deny from all
</Files>
php_flag short_open_tag on
php_flag magic_quotes_gpc off
RewriteEngine on
#RewriteCond
RewriteBase "//"
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -l [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^.*$ - [NC,L]
RewriteRule ^.*$ index.php [NC,L]
EOF

chown www-data:www-data /opt/usvn/public/.htaccess

a2enmod rewrite
/etc/init.d/apache2 restart

# show apache error log.
exec tail -f /var/log/apache2/error.log
