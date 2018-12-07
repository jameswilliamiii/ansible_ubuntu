# Ansible Strategy For Ubuntu 16.04 LTS

## Let's Encrypt Update:
* Adds `tasks/lets_encrypt.yml`
* Adds play call for Let's Encrypt to `playbook.yml`
* Adds `ansible.cfg` file to keep process from locking up when getting certs.
* Updates the nginx server templates and their names.
* Adds new Let's Encrypt specific vars to inventories.

## Modifications Required

* Update the `staging` and `production` inventory files to fill in the server IP and put values into each variable.  Be sure to generate the encrypted deploy password using the python script in the inventory files.
* Before committing any of these changes please be sure to add the inventory files to your `.gitignore`.
* Be sure the ruby_version in the inventory files matches the ruby version you have set in your app.
* SSH into your newly provisioned instance as root and add the file `~/.ssh/authorized_keys`.  Paste your public ssh key into this file and save it.
* The first time you run these scripts you will need to use the variable value `ansible_ssh_user=root`.  Once that has completed, you can run additional plays with the value of `deploy`.
* Be sure to update the file `templates/authorized_keys` with all public ssh keys that should be stored on the server for SSH access.
* The ansible scripts can upload SSL certs, and the scripts assume these will be stored in `config/ssl_certs`.  You will then need to uncomment the `name: install ssl certs` task inside `tasks/nginx.yml`.  Make sure your SSL certs are part of your `.gitignore` file as you do not want those checked in.

## Running Your Playbook

*Command*    
```
ansible-playbook -i ansible/inventory ansible/playbook.yml -K
```
*Notes*    

* Change out `staging` above with the inventory name you want to use.
* Before running your playbook, make sure you have your password ready for whichever user you have set in `ansible_ssh_user`.
* If running on AWS, then you do not need the `-K` as you do not have the password for the `root` or `ubuntu` user.

## Setting up SSL via Let's Encrypt

*Command*
```
ansible-playbook -i ansible/inventory ansible/lets_encrypt_playbook.yml -K
```
*Notes*

* Make sure your inventory var `nginx_template` is setup for the proper template name `nginx_ssl`
* Be sure you have assigned values to the vars `letsencrypt_email` and `letsencrypt_domain` in your inventory.

## After Running Complete These Steps
* We do not start services like Puma or Sidekiq due to the fact that your code may not be deployed to the server when running ansible the first time.  You can uncomment these tasks if you want those services to be started up.
* After deploying your code you can hop onto the server and run the following commands to start, stop, or restart these two services.  The tasks in this playbook add permissions to sudoers so you will not have to enter a sudo password if running the commands listed at the bottom of this section.
* You may also need to restart NGINX after your first deploy.  You can do this by running `sudo service nginx restart`.

```
sudo /bin/systemctl start puma.service
sudo /bin/systemctl stop puma.service
sudo /bin/systemctl restart puma.service

sudo /bin/systemctl start sidekiq.service
sudo /bin/systemctl stop sidekiq.service
sudo /bin/systemctl restart sidekiq.service
```
