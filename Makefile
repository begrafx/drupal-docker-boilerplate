SHELL:=/bin/bash
DRUPAL_BOILERPLATE_VERSION?=0.0.2
HOST?=drupal.dev
PROJECT_NAME?=drupal_boilerplate
DRUPAL_VERSION?=8
ENVIRONMENT?=development
CONTAINER?=ssh

all: server_up

server_up: requirements
	@export $$(cat .env | xargs) && cd infrastructure/environments/${ENVIRONMENT}/dockerv2 && docker-compose up -d

server_halt: requirements
	@export $$(cat .env | xargs) && cd infrastructure/environments/${ENVIRONMENT}/dockerv2 && docker-compose stop

server_start: requirements
	@export $$(cat .env | xargs) && cd infrastructure/environments/${ENVIRONMENT}/dockerv2 && docker-compose start

server_reload: requirements
	@export $$(cat .env | xargs) && cd infrastructure/environments/${ENVIRONMENT}/dockerv2 && docker-compose stop && docker-compose start

server_destroy: requirements
	@export $$(cat .env | xargs) && cd infrastructure/environments/${ENVIRONMENT}/dockerv2 && docker-compose stop && docker-compose rm -f

reinstall_drupal: requirements
	@export $$(cat .env | xargs) && chmod -Rf 777 public_html/sites/default/ && rm public_html/sites/default/settings.php && cp public_html/sites/default/default.settings.php public_html/sites/default/settings.php

install_drupal: requirements
	@export $$(cat .env | xargs) && docker exec -it $${DRUPAL_BOILERPLATE_PROJECT_NAME} /usr/local/bin/drush si --account-name=admin --account-pass=admin --db-url=mysql://drupal:drupal@mysql/drupal -y 2>/dev/null

ssh: requirements
	@export $$(cat .env | xargs) && docker exec -it $${DRUPAL_BOILERPLATE_PROJECT_NAME}_$${DRUPAL_BOILERPLATE_DRUPAL_VERSION}_${CONTAINER} bash

sleep:
	@sleep 5

destroy: server_destroy

clean: destroy
	@export $$(cat .env | xargs) && docker rmi drupal-boilerplate/php:$${DRUPAL_BOILERPLATE_PROJECT_NAME}_$${DRUPAL_BOILERPLATE_DRUPAL_VERSION}
	@export $$(cat .env | xargs) && docker rmi drupal-boilerplate/ssh:$${DRUPAL_BOILERPLATE_PROJECT_NAME}_$${DRUPAL_BOILERPLATE_DRUPAL_VERSION}
	@export $$(cat .env | xargs) && docker rmi drupal-boilerplate/fronttools:$${DRUPAL_BOILERPLATE_PROJECT_NAME}_$${DRUPAL_BOILERPLATE_DRUPAL_VERSION}
	@rm -Rf .env


requirements:
	@docker -v > /dev/null 2>&1 || { echo >&2 "I require docker but it's not installed. See : https://www.docker.com/"; exit 127;}
	@docker-compose -v > /dev/null 2>&1 || { echo >&2 "I require docker-compose but it's not installed. See : https://docs.docker.com/compose/install/"; exit 127;}
	@cat .env || make set_variable

set_variable:
	@echo "DRUPAL_BOILERPLATE_PROJECT_NAME=${PROJECT_NAME}" > .env
	@echo "DRUPAL_BOILERPLATE_HOST=${HOST}" >> .env
	@echo "DRUPAL_BOILERPLATE_DRUPAL_VERSION=${DRUPAL_VERSION}" >> .env
	@echo "DRUPAL_BOILERPLATE_VERSION=${DRUPAL_BOILERPLATE_VERSION}" >> .env

help:
	@echo "make server_up 			-> Up and provisione docker container."
	@echo "make server_destroy 		-> Destroy docker container."
	@echo "make server_halt 		-> Halt docker container."
	@echo "make server_start 		-> Start container already provisioned"
	@echo "make server_reload 		-> Halt and start container already provisioned"
	@echo "make destroy_install_all	-> Rebuild system an run all tests."
	@echo "make reinstall_drupal		-> Rewrite settings.php on default folder."
	@echo "make install_drupal		-> Run process to install drupal on container."
	@echo "make ssh			-> Enable us to run commands inside a container."
	@echo "make help 			-> Show that message list."
	@echo "make test_help 			-> List commands that doesn't have documentation yet."

test_help:
	@join -v 1 <(cat Makefile | grep ^[a-z][^\w]*: | cut -f1 -d":" | sort) <(make help | cut -f2 -d" " | sort)

