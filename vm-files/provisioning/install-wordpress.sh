#!/bin/bash

if [[ ! -f "/usr/local/bin/wp" ]]; 
then
	echo "Installing WP-CLI..."
	# let's save a copy of the wp-cli phar
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	# chmod and mv for global usage
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	# does it STILL work?
	wp --info --allow-root
fi

# Init Script for WordPress and WooCommerce Website
echo "Setting up WP dev box"

echo "Creating a database for the project (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS portalrevamp_dev"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON portalrevamp_dev.* TO wp@localhost IDENTIFIED BY 'wp';"

cd /srv/portalrevamp.dev/public_html/

if [[ ! -f "wp-config.php" ]];
then
    echo "Downloading Wordpress Core"
    # Download and unzip latest version of WordPress
    wp core download --allow-root

    # symlink the /srv/portalrevamp.dev/wp-content directory to the public_html directory
    if [[ -d "wp-content" && ! -L "wp-content" && -d "/srv/portalrevamp.dev/wp-content" ]];
    then
        echo "Sym-linking the wp-content project directory to site"
        rm -rf wp-content
        ln -s /srv/portalrevamp.dev/wp-content /srv/portalrevamp.dev/public_html/wp-content 
    fi

    # Use WP CLI to create a `wp-config.php` file
    wp core config --dbname="portalrevamp_dev" --dbuser=wp --dbpass=wp --dbhost="localhost" --allow-root --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_CACHE', false );
define( 'WP_HOME', 'https://portalrevamp.dev' );
define( 'WP_SITEURL', 'https://portalrevamp.dev' );
PHP

    # Use WP CLI to install WordPress
    wp core install --url="https://portalrevamp.dev" --title="The Truth About Cancer" --admin_user="admin" --admin_password='ttac2016$$' --admin_email="admin@thetruthaboutcancer.com" --allow-root
    
    # tell wordpress that we want to user pretty links
    wp rewrite structure '/%postname%' --allow-root

    # use wp-cli to update/activate theme. 
    # the "--allow-root" flag must be included.
    # This provisioning script executes as root
    # 
    # wp theme update storefront --allow-root
    # wp theme activate storefront-child --allow-root

    # use wp to activate all appropriate plugins
    #wp plugin delete hello --allow-root
    #wp plugin activate --all --allow-root
    

fi

# The Vagrant site setup script will restart Nginx for us

# Let the user know the good news
echo "WordPress Stable now installed for portalrevamp.dev";