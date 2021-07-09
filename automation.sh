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
s3_bucket=upgrad-aniruddha123
sudo tar -cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log
#sudo gzip -v /tmp/aniruddha-httpd-logs-${timestamp}.tar
aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
#
#
#
