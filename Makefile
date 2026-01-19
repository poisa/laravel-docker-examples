.PHONY: up down restart build shell composer artisan npm dev logs ps clean

# Start all containers in detached mode
up:
	docker compose -f compose.dev.yaml up -d

# Stop all containers
down:
	docker compose -f compose.dev.yaml down

# Restart all containers
restart:
	docker compose -f compose.dev.yaml restart

# Build/rebuild containers
build:
	docker compose -f compose.dev.yaml build

# Build without cache
build-fresh:
	docker compose -f compose.dev.yaml build --no-cache

# Open a bash shell in the workspace container
shell:
	docker compose -f compose.dev.yaml exec workspace bash

# Run composer commands: make composer install, make composer require laravel/sanctum
composer:
	docker compose -f compose.dev.yaml exec workspace composer $(filter-out $@,$(MAKECMDGOALS))

# Run artisan commands: make artisan migrate, make artisan make:model User
artisan:
	docker compose -f compose.dev.yaml exec workspace php artisan $(filter-out $@,$(MAKECMDGOALS))

# Run npm commands: make npm install, make npm run dev
npm:
	docker compose -f compose.dev.yaml exec workspace npm $(filter-out $@,$(MAKECMDGOALS))

# Start Vite dev server (runs in foreground)
dev:
	docker compose -f compose.dev.yaml exec workspace npm run dev

# View logs (all containers)
logs:
	docker compose -f compose.dev.yaml logs -f

# View Laravel application logs
logs-laravel:
	docker compose -f compose.dev.yaml exec workspace tail -F storage/logs/laravel.log

# View logs for specific service: make logs-php-fpm, make logs-web, make logs-mysql
logs-%:
	docker compose -f compose.dev.yaml logs -f $*

# Show running containers
ps:
	docker compose -f compose.dev.yaml ps

# Run tests
test:
	docker compose -f compose.dev.yaml exec workspace php artisan test

# Stop containers and remove volumes
clean:
	docker compose -f compose.dev.yaml down -v

# Catch-all target to allow passing arguments to commands
%:
	@:
