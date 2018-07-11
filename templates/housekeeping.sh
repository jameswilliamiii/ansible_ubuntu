#!/bin/sh

# Delete files older than 5 days
for file in `find /home/deploy/backups/ -mtime +4 -type f -name *.sql.tgz`
do
  rm $file
done

exit 0
