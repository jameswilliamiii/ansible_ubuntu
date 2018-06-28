check process puma with pidfile {{ rails_shared_dir }}/pids/puma.pid
  start program "/bin/systemctl start puma.service"
  stop program "/bin/systemctl stop puma.service"
  if 5 restarts within 5 cycles then timeout
  if totalcpu is greater than 50% for 2 cycles then alert
  if totalcpu is greater than 90% for 3 cycles then restart
  if totalmem is greater than 60% for 1 cycles then restart