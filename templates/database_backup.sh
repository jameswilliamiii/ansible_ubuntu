#!/bin/sh
echo “Initiating {{ postgres_db_name }} backup process”
DBBACK=`date +%Y%m%d%H%M%S-{{ postgres_db_name }}-backup.sql`
cd /home/deploy/backups
pg_dump {{ postgres_db_name }} > $DBBACK
tar -czf $DBBACK.tgz $DBBACK
rm $DBBACK
exit 0
