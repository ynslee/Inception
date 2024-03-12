#!/bin/sh

#Wait for MariaDB to be ready
while ! wget --spider -q mariadb:3306; do
    sleep 5
done
echo "MariaDB connection established!"

echo "Listing databases:"

# Set working dir
cd /var/www/html

# DL WP using the CLI
wp core download --allow-root

# Create WordPress database config
wp config create \
	--dbname=$MY_DB_NAME \
	--dbuser=$MY_DB_USER \
	--dbpass=$MY_DB_PASSWORD \
	--dbhost=mariadb \
	--path=/var/www/html \
	--force

# --dbcharset="utf8" --dbcollate="utf8_general_ci" \

# Install WordPress and feed db config
wp core install \
	--url=$DOMAIN_NAME \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_EMAIL \
	--allow-root \
	--skip-email \
	--path=/var/www/html

# Create WordPress user
wp user create \
	$WORDPRESS_USER \
	$WORDPRESS_EMAIL \
	--role=author \
	--user_pass=$WORDPRESS_PASSWORD \
	--allow-root

# Install theme for WordPress
wp theme install inspiro \
	--activate \
	--allow-root

# Update plugins
wp plugin update --all

# Update to match our domain
wp option update siteurl "https://$DOMAIN_NAME" --allow-root
wp option update home "https://$DOMAIN_NAME" --allow-root

# Set permissions
chown -R www:www /var/www/html
chmod -R 755 /var/www/html

# Fire up PHP-FPM (-F to keep in foreground and avoid recalling script)
php-fpm81 -F
