.PHONY:run
run:
	docker run -it --user=dev --volume $(shell pwd):/var/www/app groovytron/python:3.8 /bin/bash

.PHONY: up
up:
	docker-compose up

.PHONY: stop
stop:
	docker-compose stop

.PHONY: clean
clean:
	docker-compose down

.PHONY: jumpin-postgres
jumpin-postgres:
	docker-compose exec postgres /bin/bash

.PHONY: create-database
create-database:
	docker-compose exec postgres sh -c 'psql --dbname=hack_zurich --username=hack_zurich --password < /var/dumps/hack_zurich.sql'
