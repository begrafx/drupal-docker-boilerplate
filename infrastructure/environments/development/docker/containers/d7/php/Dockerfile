FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && rm -r /var/lib/apt/lists/* \
    && pecl install memcached \
    && docker-php-ext-install -j$(nproc) mbstring \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN cp /usr/src/php/php.ini-development /usr/local/etc/php/php.ini
RUN sed -i -- 's/memory_limit = 128M/memory_limit = 512M/g' /usr/local/etc/php/php.ini
RUN sed -i -- 's/upload_max_filesize = 2M/upload_max_filesize = 10M/g' /usr/local/etc/php/php.ini
RUN sed -i -- 's/post_max_size = 8M/post_max_size = 10M/g' /usr/local/etc/php/php.ini
RUN echo "post_max_size=10M" >> /usr/local/etc/php/php.ini
RUN echo "date.timezone=America/Sao_Paulo" >> /usr/local/etc/php/php.ini
RUN echo "always_populate_raw_post_data=-1" >> /usr/local/etc/php/php.ini
ADD conf/files.sh /usr/bin/+files
RUN chmod +x /usr/bin/+files

WORKDIR /var/www/public_html
