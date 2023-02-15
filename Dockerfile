FROM php:7.4-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev  \
    libzip-dev libonig-dev libxslt-dev git libssl-dev librabbitmq-dev nano net-tools less libmagickwand-dev openssh-client

RUN apt-get install -y --no-install-recommends nodejs npm

RUN a2enmod rewrite && a2dissite 000-default

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
   mv composer.phar /usr/local/bin/composer

RUN docker-php-ext-configure intl
RUN docker-php-ext-install pdo pdo_mysql gd opcache intl zip calendar dom mbstring zip gd xsl
RUN pecl install apcu && docker-php-ext-enable apcu
RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN pecl install amqp && docker-php-ext-enable amqp
RUN pecl install imagick && docker-php-ext-enable imagick
RUN pecl install redis && docker-php-ext-enable redis




