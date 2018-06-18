#!/bin/sh

# Delete files older than 8 days
for file in `find {{ rails_shared_dir }}/log/ -mtime +7 -type f -name *.sql.tgz`
do
  rm $file
done

exit 0
