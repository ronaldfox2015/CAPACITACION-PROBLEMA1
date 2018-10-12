
login: ## login de docker: make login
	@docker login

build: ## construccion de la imagen: make build
	docker build -f docker/node/Dockerfile -t $(TAG_DEV) docker/node/;

push: ## Subir imagen al dockerhub: make push
	@make login
	@docker push $(TAG_DEV)

