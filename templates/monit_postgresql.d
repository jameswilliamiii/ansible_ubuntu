check process postgresql with pidfile /var/run/postgresql/9.5-main.pid
    group database
    start program = "/bin/systemctl start postgresql.service"
    stop program = "/bin/systemctl stop postgresql.service"
    if failed unixsocket /var/run/postgresql/.s.PGSQL.5432 protocol pgsql then restart
    if failed unixsocket /var/run/postgresql/.s.PGSQL.5432 protocol pgsql then alert
    if failed host localhost port 5432 protocol pgsql then restart
    if failed host localhost port 5432 protocol pgsql then alert
    if 2 restarts within 2 cycles then alert
    if 5 restarts within 5 cycles then timeout