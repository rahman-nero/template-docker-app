##################### COMMON COMMANDS

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

docker-build: memory
	docker-compose up --build -d

clear-logs:
	rm ./docker/echo-server/supervisor/logs/*.log \
    && rm ./backend/storage/logs/laravel.log \
    && rm ./docker/nginx/logs/*.log \
    && rm ./docker/php-cli/supervisor/logs/*.log

memory:
	sudo sysctl -w vm.max_map_count=262144

## Выполнять команду вручную, ибо не срабатывает вот эта запись: (date "+%d_%m_%+_%H_%M")
dump-database:
	docker-compose exec mariadb mysqldump -uroot -proot app > ./backup/taptar_$(date "+%d_%m_%Y_%H_%M").sql

chown:
	docker-compose exec php-fpm chown -R www-data /var/www/storage/app
	docker-compose exec php-fpm chmod -R 755 /var/www/storage/appм

###################### BACKEND COMMANDS

# Integration tests
run-tests: pre-tests
	docker-compose exec mariadb mysql -uroot -proot -e 'drop database if exists taptar_test; create database taptar_test' && \
 	docker-compose exec php-cli php artisan cache:clear && \
 	docker-compose exec php-cli php artisan permission:cache-reset && \
 	docker-compose exec php-cli php artisan migrate --seed --env=tests && \
 	docker-compose exec php-cli php artisan test --env=tests

# Running commands before run tests
pre-tests:
	docker-compose exec php-cli php artisan key:generate --env=tests
	docker-compose exec php-cli php artisan jwt:secret --env=tests

laravel-route:
	docker-compose exec php-cli php artisan route:cache

laravel-cache:
	docker-compose exec php-cli php artisan cache:clear

laravel-migrate:
	docker-compose exec php-cli php artisan migrate

laravel-migrate-seed:
	docker-compose exec php-cli php artisan migrate --seed

laravel-storage-link:
	docker-compose exec php-cli php artisan storage:link

composer-install:
	docker-compose exec php-cli composer install

dump:
	docker-compose exec php-cli composer dumpautoload

laravel-tests:
	docker-compose exec php-cli vendor/bin/phpunit

laravel-queue:
	docker-compose exec php-cli php artisan queue:work

laravel-down:
	docker-compose exec php-cli php artisan down

laravel-up:
	docker-compose exec php-cli php artisan up

######################## FRONTEND COMMANDS
yarn-install:
	docker-compose exec npm yarn install

build-production:
	docker-compose exec npm yarn run build production

yarn-start:
	docker-compose exec npm yarn run start
