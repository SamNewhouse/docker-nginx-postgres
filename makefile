#!make

default: help

build: ## run docker compose build
	docker compose build

rebuild: ## run docker compose build
	docker compose up -d --force-recreate --build --remove-orphans

ps: ## docker compose ps
	docker compose ps

up: ## docker compose up
	docker compose up -d

down: ## docker compose down
	docker compose down

down-volumes: ## docker compose down with volumes
	docker compose down --volumes

restart: ## docker compose restart
	docker compose restart

laravel: ## create laravel project
	docker compose run app rm -rf .gitkeep
	docker compose run app composer create-project --prefer-dist laravel/laravel .

composer-install: ## composer install
	docker compose run app composer install

composer: ## run composer commands
	docker compose run app composer $(filter-out $@,$(MAKECMDGOALS))
%:

tinker: ## artisan tinker
	docker compose run app php artisan tinker

config-clear: ## config clear
	docker compose run app php artisan config:clear

cache-clear: ## cache clear
	docker compose run app php artisan cache:clear

art: ## run artisan command
	docker compose run app php artisan $(filter-out $@,$(MAKECMDGOALS))
%:
	@:	

npm: ## run npm command
	docker compose run app npm $(filter-out $@,$(MAKECMDGOALS))
%:
	@:	

migration: ## make a new migration
	docker compose run app php artisan make:migration $(filter-out $@,$(MAKECMDGOALS))
%:
	@:	

migrate: ## run artisan migrate
	docker compose run app php artisan migrate

horizon: ## run horizon
	docker compose run app php artisan horizon

permission: ## run & assign permission
	docker compose run app php artisan auth:permission

resource: ## make api resource
	docker compose run app php artisan make:resource

request: ## make request
	docker compose run app php artisan make:request

controller: ## make controller
	docker compose run app php artisan make:controller

model: ## make model
	docker compose run app php artisan make:model

pint: ## format codes with pint
	docker compose run app php ./vendor/bin/pint

test: ## run tests
	docker compose run app php artisan test

swagger: ## generate swagger
	docker compose run app php artisan l5-swagger:generate --all

# makefile help
help:
	@echo "usage: make [command]"
	@echo ""
	@echo "available commands:"
	@sed \
			-e '/^[a-zA-Z0-9_\-]*:.*##/!d' \
			-e 's/:.*##\s*/:/' \
			-e 's/^\(.\+\):\(.*\)/$(shell tput setaf 6)\1$(shell tput sgr0):\2/' \
			$(MAKEFILE_LIST) | column -c2 -t -s :
