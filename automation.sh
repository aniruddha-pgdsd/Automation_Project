#!/bin/bash
sudo apt update -y

if [ $(dpkg-query -W -f='${Status}' apache2 | grep -c "ok installed") -eq 0 ]
then
	sudo apt-get install apache2 -y
fi

if [ $(systemctl status apache2 | grep -c "active (running)") -eq 0 ]
then
	sudo systemctl start apache2
fi

if [ $(systemctl status apache2 | grep -c "apache2.service; enabled;") -eq 0 ]
then
	sudo systemctl enable apache2
fi

myname=aniruddha
timestamp=$(date '+%d%m%Y-%H%M%S')
filename=${myname}-httpd-logs-${timestamp}
s3_bucket=upgrad-aniruddha123

sudo tar -cvf /tmp/${filename}.tar /var/log/apache2/*.log
#sudo gzip -v /tmp/$filename.tar
aws s3 cp /tmp/${filename}.tar s3://${s3_bucket}/${filename}.tar

if [ ! -e /var/www/html/inventory.html ]
then
	echo -e "Log Type \tDate Created \t \tType \tSize" > /var/www/html/inventory.html
fi

size=$(du -sh /tmp/${filename}.tar | cut -f1)
echo -e "httpd-logs \t$timestamp \ttar \t$size\n" >> /var/www/html/inventory.html

if [ ! -e /etc/cron.d/automation ]
then
	sudo echo "30 20 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
	sudo chmod 600 /etc/cron.d/automation
fi
