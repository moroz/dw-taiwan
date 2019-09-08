#!/bin/sh

PROD_DB="diamondway_prod"
LOCAL_DB="diamondway_dev"
REMOTE_NAME="dw"
DATE=$(date +"%Y%m%d")

set -e

echo "Dumping DB on the remote server..."
ssh $REMOTE_NAME "pg_dump -Fc -o $PROD_DB -f ~/$DATE.dump"
echo "Fetching the DB dump..."
mkdir -p ../db
scp $REMOTE_NAME:~/$DATE.dump ../db/
echo "Dropping database..."
psql -c "drop database $LOCAL_DB"
psql -c "create database $LOCAL_DB"
echo "Restoring dump..."
pg_restore -O -d $LOCAL_DB ../db/$DATE.dump
echo "OK"
exit 0
