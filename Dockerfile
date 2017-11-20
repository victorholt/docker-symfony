FROM alpine:latest

RUN apk update
RUN apk add bash vim curl zlib wget \
    && apk add \
    php7 \
    php7-apcu \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-session \
    php7-soap \
    php7-xml \
    php7-zip \
    php7-zlib \
    php7-simplexml \
    php7-tokenizer \
    git \
	rsyslog \
	curl  \
	nano \
    zip \
    unzip \
    && rm -rf /var/cache/apk/*

ADD docker/symfony/web-php.ini /etc/php7/conf.d/
ADD docker/symfony/web.pool.conf /etc/php7/php-fpm.conf
COPY webapp/bin /var/www/bin/
COPY webapp/config /var/www/config/
COPY webapp/public /var/www/public/
COPY webapp/src /var/www/src/
COPY webapp/var /var/www/var/
COPY webapp/.env.dist /var/www/.env
COPY webapp/composer.json /var/www/
COPY docker/symfony/entrypoint.sh /var/www/

# Setup symfony/composer
COPY docker/symfony/setup.sh /usr/local/bin/setup
RUN chmod +x /usr/local/bin/setup

# Symfony cache:clear for docker
COPY docker/symfony/cc.sh /usr/local/bin/cc
RUN chmod +x /usr/local/bin/cc

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /composer

# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Run our setup.
RUN /usr/local/bin/setup

WORKDIR /var/www

#RUN composer install
EXPOSE 9000

CMD ["php-fpm7", "-F"]

ENTRYPOINT ["/var/www/entrypoint.sh"]
