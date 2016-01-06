#!/bin/bash

# install the php-fpm and necessary php modules
apt-get install -y php5-fpm php5-common php5-curl php5-dev php5-gd php5-imagick php5-mcrypt php5-memcache php5-mysql php5-pspell php5-sqlite php5-xmlrpc php5-xsl php-pear libssh2-php php5-cli php5-mcrypt

# create the directory our php-fpm sockets will run from
mkdir -p /var/run/php5-fpm/

# sockets dir must be r/w by webserver
chown -R www-data:www-data /var/run/php5-fpm

# copy the php-fpm pool conf for your vhost
cp /home/vagrant/vm-files/cp-files/php-fpm/portalrevamp.dev.conf /etc/php5/fpm/pool.d/

# restart php and nginx
service php5-fpm restart
service nginx restart

# let's install composer!
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

composer self-update
