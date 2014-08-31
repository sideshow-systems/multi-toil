#!/usr/bin/env bash

echo 'Acquire::http::Proxy "http://creanas:9999";' > /etc/apt/apt.conf.d/01proxy

apt-get update
apt-get -y upgrade

apt-get -y purge vim-tiny
apt-get install -y vim git-core 
apt-get -y purge nano

sudo apt-get install -y phpunit

echo mysql-server mysql-server/root_password select "vagrant" | debconf-set-selections
echo mysql-server mysql-server/root_password_again select "vagrant" | debconf-set-selections

apt-get install -y mysql-server apache2 php5 libapache2-mod-php5 php5-mysql

# virtual host for yii framework
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/yii/webapp"
  ServerName localhost
  <Directory "/vagrant/yii/webapp">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default
sudo a2enmod rewrite

# bugfix for VirtualBox folder sync, otherwise use nfs foldersharing in vagrantfile
# http://docs.vagrantup.com/v2/synced-folders/virtualbox.html
sudo echo 'EnableSendfile Off' >> /etc/apache2/apache2.conf

# restart apache
sudo /etc/init.d/apache2 restart

apt-get clean