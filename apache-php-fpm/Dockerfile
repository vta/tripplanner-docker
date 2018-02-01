FROM php:7.1-fpm
ENV TERM xterm
RUN apt-get update && apt-get install -y \
        imagemagick \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt php-imagick \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
#
#RUN rm /etc/nginx/sites-enabled/default
ADD sites-available/ /etc/apache2/sites-available
RUN a2ensite modeify
RUN a2enmod proxy_http proxy fastcgi alias vhost rewrite suexec
