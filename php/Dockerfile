FROM php:7.4-fpm

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y cron
RUN apt-get install -y git
RUN apt-get install -y nano libzip-dev libpng-dev zip g++ libpng-dev  nodejs npm  libxslt-dev
RUN apt-get install -y nano libjpeg-dev
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-configure zip
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure pdo_mysql
RUN docker-php-ext-configure pdo
RUN docker-php-ext-configure tokenizer
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) zip intl gd mysqli pdo pdo_mysql tokenizer sockets xsl soap bcmath ctype dom iconv


RUN echo 'memory_limit = -1' >> /usr/local/etc/php-fpm.d/docker-php-memlimit.ini;
RUN echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;
RUN echo 'max_input_vars = 100000' >> /usr/local/etc/php-fpm.d/docker-php-memlimit.ini;
RUN echo 'max_input_vars = 100000' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

WORKDIR /var/www/app

EXPOSE 9000
CMD ["php-fpm"]