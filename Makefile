.DEFAULT_GOAL := help

BUILD_TIMESTAMP ?= `date +%Y%m%d`
VERSION			:= 0.4.0
PROYECT         := ronaldgcr
TAG_DEV			:= $(PROYECT)/orbis-training-docker:$(VERSION)

install:
	docker run -d -v "$(PWD):/app" -w "/app"  $(TAG_DEV) npm install

start:
	docker run -d -p 1043:3030  -v "$(PWD):/app" -w "/app"  $(TAG_DEV) npm start

up:
	docker-compose up -d

curl:
	make up
	docker run -it --net=orbis-training-project_default node:10.10.0-slim curl nginx:3030

start-up:
	make start
	make up
release:
	docker run -v "$(PWD):/app" -w "/app"  $(TAG_DEV) npm run release

greet:
	docker run -it -v $(PWD):/app -w /app -e name="$(name)" $(TAG_DEV) bash resources/example.sh

readme:
	@echo "Hola recursos!"

login: ## login de docker: make login
	@docker login

build: ## construccion de la imagen: make build
	docker build -f docker/node/Dockerfile -t $(TAG_DEV) docker/node/;

all-images: ## Lista todas las imagenes: make all-images
	docker image
	
push: ## Subir imagen al dockerhub: make push
	@make login
	@docker push $(TAG_DEV)

list-dirs: ## Listar archivos/carpetas dentro del contenedor
	docker run $(TAG_DEV) ls $(dirs)

help: ## ayuda: make help
	@printf "\033[31m%-16s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-16s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-16s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
