FROM php:5.6-apache

ENV ENVIRONMENT production

RUN echo "[PHP] \ndate.timezone = Asia/Bangkok" >> /usr/local/etc/php/php.ini
RUN echo "[PHP] \nshort_open_tag = On" >> /usr/local/etc/php/php.ini
RUN echo "[PHP] \ndefault_charset = 'UTF-8' " >> /usr/local/etc/php/php.ini
RUN echo "[PHP] \nupload_max_filesize = 20000M" >> /usr/local/etc/php/php.ini


RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    libgd-dev \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install mysqli gd
RUN docker-php-ext-install nano

RUN a2enmod rewrite

COPY ./index.php /var/www/html/index.php

VOLUME [ "/var/www/html" ]

EXPOSE 80 443



