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

RUN git clone https://github.com/phalcon/zephir.git /usr/local/src/zephir ;\
    chmod +x /usr/local/src/zephir


RUN rm -rf /usr/local/src/cphalcon ;\
    && rm -rf /usr/local/src/zephir ;\
    apt-get clean
