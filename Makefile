SHELL:=/bin/bash
HOST:=rnp-eventos.localdomain
RED:='\033[0;31m'
NC:='\033[0m'

all: server_up reinstall_drupal sleep install_drupal

server_up:
	@cd infrastructure/environments/development/docker && docker-compose up -d

server_halt:
	@cd infrastructure/environments/development/docker && docker-compose stop

server_start:
	@cd infrastructure/environments/development/docker && docker-compose start

server_reload:
	@cd infrastructure/environments/development/docker && docker-compose stop && docker-compose start

server_destroy:
	@cd infrastructure/environments/development/docker && docker-compose stop && docker-compose rm -f

reinstall_drupal:
	@chmod -Rf 777 public_html/sites/default/ && rm public_html/sites/default/settings.php && cp public_html/sites/default/default.settings.php public_html/sites/default/settings.php

install_drupal:
	@docker exec -it d8_dev_env_php /usr/local/bin/drush si --account-name=admin --account-pass=admin --db-url=mysql://drupal:drupal@mysql/drupal -y 2>/dev/null

ssh:
	@docker exec -it d8_dev_env_php bash

sleep:
	@sleep 5

destroy_install_all: server_destroy all

destroy: server_destroy reinstall_drupal

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

