source common.sh
component=catalogue

nodejs

echo -e "${color}Install Mongodb client${nocolor}"
cp /home/centos/Roboshop-proj/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
yum install mongodb-org-shell -y &>>${log_file}
echo -e "${color}load schema${nocolor}"
mongo --host mongodb-dev.snehithdops.online <${app_path}/schema/$component.js &>>${log_file}
systemctl restart $component >>${log_file}