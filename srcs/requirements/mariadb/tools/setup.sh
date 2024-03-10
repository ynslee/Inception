#!/bin/sh

# if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
#   echo "Error: MARIADB_ROOT_PASSWORD environment variable is not set."
#   exit 1
# fi
# if [ -z "$DB_USER" ] || [ -z "$MARIADB_ROOT_PASSWORD" ]; then
#   echo "Error: DB_USER and/ or DB_USER_PASSWORD environment variable is not set."
#   exit 1
# fi

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
# chown -R mysql:mysql /var/log/mysql/error.log
touch /var/log/mysql/error.log

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

mysqld --user=mysql --bootstrap  << EOF
USE mysql ;
FLUSH PRIVILEGES ;

DROP DATABASE IF EXISTS test ;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MY_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MY_DB_USER}'@'localhost' IDENTIFIED by '${MY_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MY_DB_NAME}.* TO '${MY_DB_USER}'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO '${MY_DB_USER}'@'localhost' IDENTIFIED BY '${MY_DB_PASSWORD}' WITH GRANT OPTION;

FLUSH PRIVILEGES ;

EOF

# GRANT SELECT ON mysql.* TO 'yoonslee'@'%';
# GRANT SELECT ON inception_db.* TO 'yoonslee'@'%';
# exec mysql_secure_installation
exec mysqld_safe "--defaults-file=/etc/my.cnf.d/my.cnf"