FROM php:7.4.30-apache-bullseye

COPY dist /var/www/html
COPY fix-https-reverse-proxy.diff /var/www/html

RUN ls;

RUN set -ex; \
	apt-get update; \
	apt-get install -y unzip; \
	docker-php-ext-install pdo_mysql; \
	docker-php-ext-install mysqli; \
	apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/*; \
	docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
	docker-php-ext-install imap; \
	a2enmod rewrite; \
	chmod 777 /var/www/html/api/config.php /var/www/html/api/files; \
	chmod -R 777 /var/www/html/api/vendor/ezyang/htmlpurifier/library/HTMLPurifier/DefinitionCache/; \
    patch /var/www/html/index.php < /var/www/html/fix-https-reverse-proxy.diff;

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
