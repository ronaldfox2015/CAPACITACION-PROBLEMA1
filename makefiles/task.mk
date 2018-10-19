
login: ## login de docker: make login
	@docker login

build: ## construccion de la imagen: make build
	docker build -f docker/node/Dockerfile -t $(TAG_DEV) docker/node/;

create-network:
	docker network create $(NAME)

test:
	@make build VERSION=test
	@make create-network NAME=test
	docker run -it --net=test $(USER)/orbis-training-docker:test curl nginx:3030

push: ## Subir imagen al dockerhub: make push
	@make login
	@docker push $(TAG_DEV)

