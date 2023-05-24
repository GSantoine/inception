FROM	debian:buster

RUN	apt-get update -y && apt-get upgrade -y
RUN	apt-get install wget -y \
		php7.3 -y \
		php-fpm -y \
		php-mysql -y \
		curl -y \
		mariadb-client -y

RUN	wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www
RUN	cd /var/www && tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz

COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN	chown -R root:root /var/www/wordpress

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp


COPY	./tools/auto_config.sh ./auto_config.sh
RUN	chmod 755 ./auto_config.sh

ENTRYPOINT ["bash", "./auto_config.sh"]
