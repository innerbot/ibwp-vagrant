#!/bin/bash
# create the mysql init file to start mysql on system startup
cp /home/vagrant/vm-files/cp-files/mariadb/etc_init_mysql.conf /etc/init/mysql.conf

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
cp "/home/vagrant/vm-files/cp-files/mariadb/my.cnf.orig" "/etc/mysql/my.cnf"

service mysql restart