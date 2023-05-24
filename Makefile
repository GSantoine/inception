# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agras <agras@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/09 15:01:38 by agras            #+#    #+#               #
#    Updated: 2023/02/25 14:36:59 by agras           ###   ########.fr         #
#                                                                              #
# **************************************************************************** #

DOCKER_VOLUME_LIST :=	$(shell docker volume ls -q)
COMPOSE_FILE := 			srcs/docker-compose.yml

all: volumes build
	@echo "docker containers built ! OK"

volumes:
	mkdir -p ${HOME}/data/mariadb
	mkdir -p ${HOME}/data/wordpress

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up

stop:
	docker compose -f $(COMPOSE_FILE) stop

re: fclean all

clean: stop
	docker compose -f $(COMPOSE_FILE) down

fclean: clean
	sudo rm -rf ${HOME}/data/mariadb
	sudo rm -rf ${HOME}/data/wordpress
	docker system prune -af
	@if [ -n "$(DOCKER_VOLUME_LIST)" ]; then docker volume rm $(DOCKER_VOLUME_LIST) ; fi
	@echo "Clean !"

	
.PHONY: clean fclean all re
