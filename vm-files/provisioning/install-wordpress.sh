#!/bin/bash

# let's save a copy of the wp-cli phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# chmod and mv for global usage
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# does it STILL work?
wp --info

# Init Script for WordPress and WooCommerce Website
echo "Setting up WP and WooCommerce E-Commerce Platform base"

echo "Creating a database for the project (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS portalrevamp_dev"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON portalrevamp_dev.* TO wp@localhost IDENTIFIED BY 'wp';"

cd /srv/portalrevamp.dev/public_html/

if [ ! -f "wp-config.php" ]
then
    echo "Downloading Wordpress Core"
    # Download and unzip latest version of WordPress
    wp core download --allow-root
    # Use WP CLI to create a `wp-config.php` file
    wp core config --dbname="portalrevamp_dev" --dbuser=wp --dbpass=wp --dbhost="localhost" --allow-root
    # Use WP CLI to install WordPress
    wp core install --url="https://portalrevamp.dev" --title="The Truth About Cancer" --admin_user="admin" --admin_password='ttac2016$$' --admin_email="admin@thetruthaboutcancer.com" --allow-root
    
    # use wp to change active theme
    wp theme update storefront --allow-root
    wp theme activate storefront-child --allow-root

    # use wp to activate all appropriate plugins
    wp plugin delete hello --allow-root
    wp plugin activate --all --allow-root
fi

# The Vagrant site setup script will restart Nginx for us

# Let the user know the good news
echo "WordPress Stable now installed for bwmc.dev";