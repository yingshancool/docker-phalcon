FROM php:5.6.23-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        git \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN git clone https://github.com/phalcon/cphalcon.git /usr/local/src/cphalcon \
    && cd /usr/local/src/cphalcon/build \
    && ./install \
    && docker-php-ext-enable -j$(nproc) phalcon

RUN rm -rf /usr/local/src/cphalcon \
    && apt-get clean
