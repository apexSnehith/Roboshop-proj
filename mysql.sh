echo -e "\e[32mDisblin the previous sql version\e[0m"
yum module disable mysql -y &>> /tmp/roboshop.log

echo -e "\e[32mSetting up the mysql repo\e[0m"
cp /home/centos/Roboshop-proj/mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/roboshop.log

echo -e "\e[32minstalling the MySQL Server\e[0m"
yum install mysql-community-server -y &>> /tmp/roboshop.log

echo -e "\e[32mStarting&Enabling the service\e[0m"
systemctl enable mysqld &>> /tmp/roboshop.log
systemctl restart mysqld &>> /tmp/roboshop.log

echo -e "\e[32mChanging the default root password\e[0m"
mysql_secure_installation --set-root-pass $1 &>> /tmp/roboshop.log
#mysql -uroot -pRoboShop@1