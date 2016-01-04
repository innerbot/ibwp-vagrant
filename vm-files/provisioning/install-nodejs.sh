#!/bin/bash

# let's add the nodesource repo so we can get a 5.x version of nodejs
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -

# first let's install node
sudo apt-get install -y nodejs

# test that install is working
curl -sL https://deb.nodesource.com/test | bash - 

# now let's install some packages globally
sudo npm install -g grunt bower node-sass gulp node-bourbon