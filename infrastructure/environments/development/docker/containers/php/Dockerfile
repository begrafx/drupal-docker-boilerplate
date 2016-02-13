FROM php:7.0-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-enable opcache \
    && docker-php-ext-install -j$(nproc) mbstring \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get update && apt-get install -y curl wget git mysql-client && rm -r /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin

RUN wget http://files.drush.org/drush.phar && chmod +x drush.phar && mv drush.phar /usr/local/bin/drush && drush init -y

RUN curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && drupal init --override

RUN cp /usr/src/php/php.ini-development /usr/local/etc/php/php.ini

RUN sed -i -- 's/memory_limit = 128M/memory_limit = 256M/g' /usr/local/etc/php/php.ini

RUN echo "date.timezone=America/Sao_Paulo" >> /usr/local/etc/php/php.ini
RUN echo "always_populate_raw_post_data=-1" >> /usr/local/etc/php/php.ini

WORKDIR /var/www/public_html