#!/bin/bash

# echo 'deb http://packages.dotdeb.org squeeze all' >> /etc/apt/sources.list.d/DotDeb.list
# echo 'deb-src http://packages.dotdeb.org squeeze all' >> /etc/apt/sources.list.d/DotDeb.list

# # add the key for the dotdeb repo
# wget https://www.dotdeb.org/dotdeb.gpg
# apt-key add dotdeb.gpg
# rm dotdeb.gpg

# update packages db so we can install packages from new repositories
apt-get update