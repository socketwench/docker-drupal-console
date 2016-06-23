FROM php
MAINTAINER tess@deninet.com

# Grab dependencies for php-gd.
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libicu-dev \
    mysql-client

# Enable php modules.
RUN docker-php-ext-install gd json intl pdo pdo_mysql mysqli mbstring opcache

# Download console.
RUN curl https://drupalconsole.com/installer -L -o drupal.phar

# Install console.
RUN mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal && \
    drupal init --override

WORKDIR /var/www/html

RUN drupal settings:set checked "true"

ENTRYPOINT ["drupal"]
