#!/bin/bash

# install the php-fpm and necessary php modules
apt-get install -y php5-fpm php5-common php5-curl php5-dev php5-gd php5-imagick php5-mcrypt php5-pspell php5-sqlite php5-xmlrpc php5-xsl php-pear libssh2-php php5-cli php5-mysqlnd

# create the php5-fpm init file to start php5-fpm on system startup
cp /home/vagrant/vm-files/cp-files/php-fpm/etc_init_php5-fpm.conf /etc/init/php5-fpm.conf

# create sockets dir 
mkdir -p /var/run/php-fpm
# chown -R www-data:www-data /var/run/php5-fpm

# copy the php-fpm pool conf for your vhost
cp /home/vagrant/vm-files/cp-files/php-fpm/portalrevamp.dev.conf /etc/php5/fpm/pool.d/

# restart php and nginx
service php5-fpm restart
service nginx restart

# let's install composer!
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

composer self-update
