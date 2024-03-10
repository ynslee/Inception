FROM alpine:3.18

COPY conf/maridb.conf /etc/my.cnf.d/mariadb.cnf
WORKDIR /

RUN apk update && apk add --no-cache mariadb-server mariadb-client && \
	chmod 644 /etc/my.cnf.d/mariadb.cnf
	# mkdir -p /run/mysqld && \
	# chown -R mysql:mysql /run/mysqld && \

	# vim && \
	# rm -rf /var/cache/apk/* 

EXPOSE 3306

CMD ["setup.sh"]
