FROM	alpine:3.18

RUN		apk update && \
		apk add --no-cache --quiet --update curl bash wget composer && \
		#Client for MariaDB to interact with MariaDB/MySQL databases
		apk add --no-cache --quiet --update mariadb-client && \
		apk add --no-cache --quiet --update php81 php-phar php-json php-curl php-fpm php-mysqli php-iconv && \
		# adduser -S www &&	addgroup -S www && \
		addgroup -S www && adduser -S -H -g "" www -G www && \
		mkdir -p /run/php/ && mkdir -p /var/www/html/wordpress

COPY	conf/www.conf /etc/php81/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar &&cp wp-cli.phar /usr/local/bin/wp && chmod +x /usr/local/bin/wp


COPY tools/setup.sh /tmp/wordpress.sh
RUN chmod +x /tmp/wordpress.sh

EXPOSE 9000

CMD [ "sh", "/tmp/wordpress.sh" ]