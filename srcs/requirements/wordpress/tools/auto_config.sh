#!/bin/bash

sleep 30

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	echo "configuring Wordpress..."
	wp config create --allow-root \
			--dbname=${DATABASE} \
			--dbuser=${DB_USER} \
			--dbpass=${DB_USER_PWD} \
			--dbhost=mariadb:3306 --path=${WP_PATH}

	wp core install --allow-root \
			--url=${URL} \
			--title=${P_NAME} \
			--admin_user=${WP_ADMIN} \
			--admin_password=${WP_ADMIN_PWD} \
			--admin_email=${WP_ADMIN_MAIL} \
			--skip-email \
			--path=${WP_PATH}

	wp user create --allow-root \
			${WP_USER} ${WP_USER_MAIL} \
			--user_pass=${WP_USER_PWD} \
			--role=editor \
			--path=${WP_PATH}

else
	echo "Wordpress already configured."
fi

if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi

echo "Wordpress configured !"
/usr/sbin/php-fpm7.3 -F
