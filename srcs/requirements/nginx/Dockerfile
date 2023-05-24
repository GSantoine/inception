FROM	debian:buster

RUN	apt-get update -y && apt-get upgrade -y && apt-get install openssl -y nginx -y

RUN	mkdir -p /etc/nginx/ssl
RUN	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=agras.42.fr/UID=agras"

RUN	mkdir -p /var/run/nginx
RUN	chmod 755 /var/www/html
RUN	chown -R www-data:www-data /var/www/html

COPY	./conf/nginx.conf  /etc/nginx/nginx.conf

CMD	[ "nginx", "-g", "daemon off;" ]
