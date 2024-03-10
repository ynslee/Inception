#!/bin/sh

if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
  echo "Error: MARIADB_ROOT_PASSWORD environment variable is not set."
  exit 1
fi
if [ -z "$DB_USER" ] || [ -z "$MARIADB_ROOT_PASSWORD" ]; then
  echo "Error: DB_USER and/ or DB_USER_PASSWORD environment variable is not set."
  exit 1
fi

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql 
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
touch /var/log/mysql/error.log

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >> /dev/null

mysqld --user=mysql --bootstrap  << EOF
USE mysql ;
FLUSH PRIVILEGES ;

ALTER USER 'root'@'localhost' IDENTIFIED BY'${MARIADB_ROOT_PASSWORD}' ;
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '$DB_USER_PASSWORD' ;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' ;
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' ;
FLUSH PRIVILEGES ;

EOF

exec mysqld_safe "--defaults-file=/etc/my.cnf.d/mariadb.cnf"