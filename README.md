# D8 Development Environment

Boilerplate to start Drupal 8 Projects

## Requirements

- make command
- Docker 1.8+
- Docker Composer

## Instalation

Clone this project and inside download drupal inside a public_html folder, after that type the make command inside a root folder:

```shell
$ make
```

## Commands

In order to make more easy, we create some commands inside a Make file

### Examples

| Command 					| Description 										|
|---------------------------|---------------------------------------------------|
| make 		 				| Provision container and install drupal.			|
| make server_up 			| Up and provisione docker container.				|
| make server_destroy 		| Destroy docker container.							|
| make server_halt 			| Halt docker container.							|
| make server_start 		| Start container already provisioned.				|
| make server_reload 		| Halt and start container already provisioned.		|
| make destroy_install_all	| Rebuild system an run again.						|
| make reinstall_drupal		| Rewrite settings.php on default folder.			|
| make install_drupal		| Run process to install drupal on container.		|
| make ssh					| Enable us to run commands inside a container.		|
| make help 				| Show that message list.							|
| make test_help 			| List commands that doesn't have documentation yet.|
| make destroy 				| Destroy containers and rewrite settings.php.		|


Licence
-------

GPL version 2

In this project
------------------

João Paulo Seregatte Costa <seregatte@gmail.com>
