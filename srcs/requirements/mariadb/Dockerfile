FROM	debian:buster

RUN		apt-get update -y && apt-get upgrade -y && apt-get install mariadb-server -y sudo -y

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d

COPY	./tools/mariadb_init.sh ./mariadb_init.sh
RUN		chmod 755 mariadb_init.sh

RUN	mkdir -p /var/run/mysqld
RUN	sudo chown mysql:mysql /var/run/mysqld/
RUN	sudo chmod -R 755 /var/run/mysqld/

ENTRYPOINT	["sh", "./mariadb_init.sh"]

EXPOSE	3306
