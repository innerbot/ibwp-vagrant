#!/bin/bash


# add key for fetching mariadb 10.0.x
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/10.0/ubuntu trusty main'

# update packages db and install
apt-get update -y

# set the root pass manually before attempting install
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password root'

# install maria-db 10 server
apt-get install -y mariadb-server

# backup config file
cp "/etc/mysql/my.cnf" "/etc/mysql/my.cnf.orig"

# copy config files
cp "/srv/portalrevamp.dev/public_html/vm-files/cp-files/mariadb/my.cnf" "/etc/mysql/my.cnf"
cp "/srv/portalrevamp.dev/public_html/vm-files/cp-files/mariadb/root-my.cnf" "/etc/mysql/root-my.cnf"

service mysql restart