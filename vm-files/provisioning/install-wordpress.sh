#!/bin/bash

# let's save a copy of the wp-cli phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# chmod and mv for global usage
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# does it STILL work?
wp --info