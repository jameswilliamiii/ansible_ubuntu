check process sidekiq with pidfile {{ rails_shared_dir }}/pids/sidekiq.pid
    start program = "/bin/systemctl start sidekiq.service" with timeout 60 seconds
    stop program = "/bin/systemctl stop sidekiq.service"