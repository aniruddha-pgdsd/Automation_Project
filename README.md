# Automation_Project


=> Created automation.sh BASH script as part of DevOps Essential course assignment(task2) of Upgrad. 

=> This script should first run apt update to download latest package. 

=> Next, it will check whether apache2 is installed on the system, if not it will install the same. 

=> Next, it will check if the apache2 service is running, if not script will srart the service. 

=> Next, it will check if the aforementioned service is enabled as daemon. if not it will enable. 

=> After that, script will make an archive of apache2 logs and copy to the /tmp/ location with my name & timestamp. 

=> I'm not sure whether to compress that archive further, added a command for the same but left commented out. 

=> Next, another command to copy that tar file to the s3_bucket. 

=> Hope, it makes sense and readable, thanks. 

=> As part of task 3 of the assignment, script will now create an inventory.html if not present and append with some required information whenever it runs

=> Also, a cron job has been set within the script to create a file under /etc/cron.d/ directory and scheduled to run daily by root user. 
