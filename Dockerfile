FROM php:7.2-apache


#       wordpress needs mod-rewrite enabled in apache, which is disabled in default php:7-apache image.

RUN  apt-get update && apt-get install -y --no-install-recommends \
         libjpeg-dev \
         libpng-dev 
RUN  docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli opcache \
    && a2enmod rewrite expires
#WORKDIR /var/www/html 
RUN curl -# -LO https://wordpress.org/latest.tar.gz 
RUN tar xzf latest.tar.gz 
RUN mv wordpress/* /var/www/html/ 
RUN chown 33:33 /var/www/html -R
#CMD ["usr/bash/apache2","-D","FOREGROUND"]
