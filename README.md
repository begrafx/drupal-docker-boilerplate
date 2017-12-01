# Drupal Development Environment [![Build Status](https://travis-ci.org/seregatte/drupal-docker-boilerplate.svg?branch=master)](https://travis-ci.org/seregatte/drupal-docker-boilerplate)

Boilerplate to start Drupal 8 Projects based on docksal

## Requirements

- Docksal

## Instalation

Clone this project and download drupal inside a docroot folder, after that type the fin command inside a root folder:

```shell
$ fin up
```

or you can create the project via composer.

If you have a php cli stack and composer, try this:

```
composer create-project seregatte/drupal-composer-boilerplate some-dir --stability dev --no-interaction
```

or if you prefer run via docker:

```
docker run --rm -v $(pwd):/app composer/composer create-project seregatte/drupal-composer-boilerplate some-dir --stability dev --no-interaction
```

Licence
-------

GPL version 2

In this project
------------------

João Paulo Seregatte Costa <seregatte@gmail.com>
