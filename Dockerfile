FROM 'urbit/lumen-nginx'
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --from='alpine/git' /usr/bin/git /usr/local/bin/git
# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN git clone https://github.com/jikan-me/jikan-rest.git  \
 && composer install --prefer-dist --no-progress --no-suggest --classmap-authoritative  --no-interaction

#ADD .env /run-jikan.sh ./

# ENTRYPOINT ["docker-php-entrypoint"]
ENTRYPOINT ["./run-jikan.sh"]
