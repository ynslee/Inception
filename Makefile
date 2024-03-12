YML_PATH = srcs/docker-compose.yml
FILES_PATH = /home/yoonslee/data

.PHONY: up down ps clean fclean prune re all reset info

all:
	@if [ ! -d "$(FILES_PATH)/mariadb" ]; then \
		sudo mkdir -p $(FILES_PATH)/mariadb; \
		sudo chmod -R 777 $(FILES_PATH)/mariadb; \
	fi
	@if [ ! -d "$(FILES_PATH)/wordpress" ]; then \
		sudo mkdir -p $(FILES_PATH)/wordpress; \
		sudo chmod -R 777 $(FILES_PATH)/wordpress; \
	fi
	@if ! grep -q "yoonslee.42.fr" /etc/hosts; then \
		sudo chmod 777 /etc/hosts; \
		echo "127.0.0.1 yoonslee.42.fr" >> /etc/hosts; \
	fi
	@if ! grep -q "yoonslee.42.fr" /etc/hosts; then \
		sudo chmod 777 /etc/hosts; \
		echo "127.0.0.1 yoonslee.42.fr" >> /etc/hosts; \
	fi
	sudo docker compose -f $(YML_PATH) up -d

up:
	sudo docker compose -f $(YML_PATH) up -d

down:
	sudo docker compose -f $(YML_PATH) down

ps:
	sudo docker compose -f $(YML_PATH) ps

clean:
	sudo docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@if [ -d $(FILES_PATH) ]; then \
			sudo rm -rf $(FILES_PATH); \
	fi;

prune:
	sudo docker system prune --all --force --volumes

reset:
	sudo docker stop $(docker ps -a -q); sudo docker rm $(docker ps -qa); \
	sudo docker rmi -f $(docker images -qa); sudo docker volume rm $(docker volume ls -q); \
	sudo docker network rm $(docker network ls -q)

re: fclean all

info:
	@echo "==================== IMAGES ===================="
	@sudo docker images
	@echo
	@echo "============================= CONTAINERS ============================="
	@sudo docker ps -a
	@echo
	@echo "=============== NETWORKS ==============="
	@sudo docker network ls
	@echo
	@echo "====== VOLUMES ======"
	@sudo docker volume ls
