#!/bin/bash

# update packages db so we can install packages from new repositories
apt-get update
# install some utilities we may need
apt-get install -y htop imagemagick poppler-utils