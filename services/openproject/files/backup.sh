#!/bin/bash
sqlpw=$(cat /mysql-root-pw.txt)
mysqldump -u root -p$sqlpw –all-databases –routines| gzip > /root/sqldump/MySQLDB_`date ‘+%m-%d-%Y’`.sql.gz