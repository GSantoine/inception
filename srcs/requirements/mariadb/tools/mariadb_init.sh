#!/bin/bash

# DATABASE="database"

# DB_USER="agras"
# DB_USER_PWD="bobsquarepants$345"

# DB_ROOT_PWD="squareroot$799"

if [ ! -f "/var/lib/mysql/.already_init" ]; then
	service mysql start;
	sleep 5
	echo "configuring Mariadb...";
	mysql -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_USER_PWD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${DATABASE}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USER_PWD}';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';"
	mysql -u root -p${DB_ROOT_PWD} -e "FLUSH PRIVILEGES;"
	mysqladmin -u root -p${DB_ROOT_PWD} shutdown
	echo "Database created and initialized."
	touch /var/lib/mysql/.already_init
else
	echo "Mariadb database already configured."
fi

echo "Mariadb configured !"
exec mysqld_safe
