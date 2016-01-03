#!/bin/bash

apt-get install -y nginx-extras

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
mv /etc/nginx/fastcgi_params /etc/nginx/fastcgi_params.orig


# install self-signed certificate
mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
openssl req -x509 -nodes -batch -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

# copy config files into nginx locations
cp /srv/portalrevamp.dev/public_html/vm-files/cp-files/nginx/nginx.conf /etc/nginx
cp /srv/portalrevamp.dev/public_html/vm-files/cp-files/nginx/fastcgi_params /etc/nginx
cp /srv/portalrevamp.dev/public_html/vm-files/cp-files/nginx/nginx-wp-common.conf /etc/nginx
cp /srv/portalrevamp.dev/public_html/vm-files/cp-files/nginx/portalrevamp.dev /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default #removing default

chown -R www-data:www-data /var/log/nginx
chmod -R 755 /var/log/nginx

# enable the dev site vhost
ln -s /etc/nginx/sites-available/portalrevamp.dev /etc/nginx/sites-enabled/portalrevamp.dev
