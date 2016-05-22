FROM drupal-boilerplate/php:8.0.2

RUN apt-get update \
    && apt-get install -y curl vim git mysql-client \
    && rm -r /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin && ln -s /usr/bin/composer.phar /usr/bin/composer

RUN curl -O http://files.drush.org/drush.phar && chmod +x drush.phar && mv drush.phar /usr/local/bin/drush && drush init -y

RUN curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && drupal init --override

RUN composer.phar global require drupal/drupal-extension:~3.0
RUN ln -s /root/.composer/vendor/bin/behat /usr/bin/behat

# Setup SSH.
RUN apt-get update \
    && apt-get install -y openssh-server \
    && rm -r /var/lib/apt/lists/*
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

EXPOSE 22
WORKDIR /var/www/public_html
CMD ["/usr/sbin/sshd", "-D"]
