# Ansible Strategy For Ubuntu 16.04 LTS

## Modifications Required

* Update the `staging` and `production` inventory files to fill in the server IP and put values into each variable.  Be sure to generate the encrypted deploy password using the python script in the inventory files.
* Before committing any of these changes please be sure to add the inventory files to your `.gitignore`.
* Be sure the ruby_version in the inventory files matches the ruby version you have set in your app.
* SSH into your newly provisioned instance as root and add the file `~/.ssh/authorized_keys`.  Paste your public ssh key into this file and save it.
* The first time you run these scripts you will need to use the variable value `ansible_ssh_user=root`.  Once that has completed, you can run additional plays with the value of `deploy`.
* Be sure to update the file `templates/authorized_keys` with all public ssh keys that should be stored on the server for SSH access.
* The ansible scripts can upload SSL certs, and the scripts assume these will be stored in `config/ssl_certs`.  You will then need to uncomment the `name: install ssl certs` task inside `tasks/nginx.yml`.

## Running Your Playbook

*Command*    
```
ansible-playbook -i staging ansible/playbook.yml -K
```
*Notes*    

* Change out `staging` above with the inventory name you want to use.
* Before running your playbook, make sure you have your password ready for whichever user you have set in `ansible_ssh_user`.

## After Running Complete These Steps
* We do not start services like Puma or Sidekiq due to the fact that your code is not deployed to the server when originally running.  You can uncomment these tasks if you want those services to be started up.
* After deploying your code you can hop onto the server and run the following commands to start, stop, or restart these two services.  The tasks in this playbook add permissions to sudoers so you will not have to enter a sudo password if running the following commands:

  ```
  sudo /bin/systemctl start puma.service
  sudo /bin/systemctl stop puma.service
  sudo /bin/systemctl restart puma.service

  sudo /bin/systemctl start sidekiq.service
  sudo /bin/systemctl stop sidekiq.service
  sudo /bin/systemctl restart sidekiq.service
  ```

* You may also need to restart NGINX after your first deploy.  You can do this by running `sudo service nginx restart`.
