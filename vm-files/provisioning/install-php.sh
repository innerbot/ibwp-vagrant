#!/bin/bash

apt-get install -y php5 php5-fpm php5-common php5-curl php5-dev php5-gd php5-imagick php5-mcrypt php5-memcache php5-mysql php5-pspell php5-sqlite php5-xmlrpc php5-xsl php-pear libssh2-php php5-cli

mkdir -p /var/run/php5-fpm/

chown -R www-data:www-data /var/run/php5-fpm

cp /srv/portalrevamp.dev/public_html/vm-files/cp-files/php-fpm/portalrevamp.dev.conf /etc/php5/fpm/pool.d/

service nginx restart

service php5-fpm restart