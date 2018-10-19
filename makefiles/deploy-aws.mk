.PHONY: deploy.aws

ENV            ?= dev
DEPLOY_DIR      = deploy
BUILD_DIR       = build
DEPLOY_REGION  ?= eu-west-1
DEPLOY_BUCKET   = $(ENV)-orbis-training

deploy.aws: ## Desplegando bucket.: make deploy.aws
    @echo "Desplegando cambios al bucket: $(DEPLOY_BUCKET)"