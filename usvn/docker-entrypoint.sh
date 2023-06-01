#!/bin/bash
set -x
cd

if [[ ! -d /var/lib/svn/config || ! -d /var/lib/svn/files ]];then
    mkdir -p /var/lib/svn/config /var/lib/svn/files
    chown -R 33.33 /var/lib/svn
fi
rm -rf /var/www/html/config /var/www/html/files
ln -snf /var/lib/svn/config /var/www/html/
ln -snf /var/lib/svn/files /var/www/html/
chown -R 33.33 /var/www/html/
chmod -R 755 /var/www/html/

if [ "x${USVN_SUBDIR}" = "x" ]; then
    #apache设置
    cat << EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/public
        <Directory /var/www/html/public>
                AllowOverride all
                Options -MultiViews
                Order Deny,Allow
                Allow from all
                Require all granted
        </Directory>
</VirtualHost>
EOF

else
    #apache设置
    basedir=$(basename ${USVN_SUBDIR})
    pdir=$(dirname ${USVN_SUBDIR})
    if [[ ${pdir} = '.' || ${pdir} = '/' ]];then
        alias=/${basedir}
    else
        alias=${pdir}/${basedir}
    fi
    cat << EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        Alias ${alias} /var/www/html/public
        #DocumentRoot /var/www/html/public
        <Directory /var/www/html/public>
                AllowOverride all
                Options -MultiViews
                Order Deny,Allow
                Allow from all
                Require all granted
        </Directory>
</VirtualHost>
EOF
fi


cat << EOF > /etc/apache2/mods-enabled/dav_svn.conf
<Location ${USVN_SUBDIR}/svn/>
	ErrorDocument 404 default
	DAV svn
	Require valid-user
	SVNParentPath /var/lib/svn/files/svn
	SVNListParentPath off
	AuthType Basic
	AuthName "USVN"
	AuthUserFile /var/lib/svn/files/htpasswd
	AuthzSVNAccessFile /var/lib/svn/files/authz
</Location>
EOF

cat << EOF > /var/www/html/public/.htaccess
<Files *.ini>
    Require all denied
</Files>
php_flag short_open_tag on
php_flag magic_quotes_gpc off
RewriteEngine on
#RewriteCond
RewriteBase "/${alias}/"
RewriteRule ^svn/ - [L,NC]
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -l [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^.*$ - [NC,L]
RewriteRule ^.*$ index.php [NC,L]
EOF

chown www-data:www-data /var/www/html/public/.htaccess
a2enmod rewrite

exec "$@"
