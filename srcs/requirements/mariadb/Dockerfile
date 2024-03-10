FROM alpine:3.18

COPY ./conf/mariadb.cnf /etc/my.cnf.d/my.cnf
COPY ./tools/setup.sh /tmp/setup.sh

RUN apk update && apk add --no-cache mariadb mariadb-client && \
	chmod +x /tmp/setup.sh
	# mkdir -p /run/mysqld && \
	# chown -R mysql:mysql /run/mysqld && \

	# vim && \
	# rm -rf /var/cache/apk/* 

EXPOSE 3306

CMD ["sh", "/tmp/setup.sh"]
