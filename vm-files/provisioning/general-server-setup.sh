#!/bin/bash

# update packages db so we can install packages from new repositories
apt-get update -y

# install some utilities we may need
apt-get install -y htop imagemagick poppler-utils software-properties-common git subversion

# copy over the startup script that boots nginx, php, mysql
cp /srv/portalrevamp.dev/public_html/vm-files/cp-files/ibwp-vagrant.conf /etc/init/ibweb-start.conf