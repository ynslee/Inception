#!/bin/sh

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
  echo "Error: MARIADB_ROOT_PASSWORD environment variable is not set."
  exit 1
fi
if [ -z "$MYSQL_USER" ] || [ -z "$MYSQLROOT_PASSWORD" ]; then
  echo "Error: DB_USER and/ or DB_USER_PASSWORD environment variable is not set."
  exit 1
fi

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql /error/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /error/log/mysql
touch /var/log/mysql/error.log

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >> /dev/null

mysqld --user=mysql --bootstrap  << _EOF_
USE mysql ;
FLUSH PRIVILEGES ;

ALTER USER 'root'@'localhost' IDENTIFIED BY '{$MYSQL_ROOT_PASSWORD}' ;
CREATE DATABASE IF NOT EXISTS {$MYSQL_HOST} ;
CREATE USER '{$MYSQL_USER}'@'%' IDENTIFIED BY '{$MYSQL_ROOT_PASSWORD}' ;
GRANT ALL PRIVILEGES ON {$MYSQL_HOST}.* TO '{$MYSQL_USER}'@'%' ;
GRANT ALL PRIVILEGES ON *.* TO '{$MYSQL_USER}'@'%' ;
FLUSH PRIVILEGES ;
_EOF_

exec mysqld_safe "--defaults-file=/etc/my.cnf.d/mariadb.cnf"