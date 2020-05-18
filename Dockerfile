FROM 'urbit/lumen-nginx'
FROM php:7.3-cli-alpine
FROM php:7.3-fpm-alpine
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
#COPY --from='alpine/git' /usr/bin/git /usr/local/bin/git
# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ add \
    git \
    unzip \
    openssl \
    openssl-dev \
    libcurl \
    pcre2 \
 && rm -rf /var/cache/apk/* /tmp/* \
 && git clone https://github.com/jikan-me/jikan-rest.git . \
 && composer install --prefer-dist --no-progress --no-suggest --classmap-authoritative  --no-interaction

#ADD .env /run-jikan.sh ./

# ENTRYPOINT ["docker-php-entrypoint"]
ENTRYPOINT ["./run-jikan.sh"]
