FROM ubuntu:18.04

WORKDIR /var/application/estimator2018

ENV TZ Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get update && apt-get install -y \
    php7.2 \
    php7.2-mbstring \
    php-xml \
    php7.2-zip \ 
    php7.2-curl \
    php7.2-mysql

RUN apt-get update && apt-get install -y \
    openssh-client \
    curl \
    git \
    vim

RUN curl https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php
RUN rm composer-setup.php
RUN cp composer.phar /usr/bin/composer

COPY ./entrypoint.sh .
COPY ./nginx_default.conf /etc/nginx/conf.d/default

ENTRYPOINT [ "/bin/sh", "entrypoint.sh" ]
    
