FROM mysql/mysql-server

COPY my.cnf /etc/my.cnf
COPY create.admin.sql /docker-entrypoint-initdb.d/create.admin.sql

RUN chmod 640 /docker-entrypoint-initdb.d/create.admin.sql

