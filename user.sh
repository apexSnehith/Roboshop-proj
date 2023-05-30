echo -e "\e[32mSetting up the NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[32mInstalling NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[32mAdding the user for the service\e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app &>>/tmp/roboshop.log
echo -e "\e[32mmaking a directory \e[0m"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[32mDowloding the application code \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[32mExtracting the file\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
echo -e "\e[32mInstalling the dependencies \e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[32mSetting up the service \e[0m"
cp /home/centos/Roboshop-proj/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log
echo -e "\e[32mEnabling&restarting the service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enabling user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log
echo -e "\e[32mSetting up the schema to install the mongodb client \e[0m"
cp /home/centos/Roboshop-proj/mongo.repo /etc/systemd/system/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[32mInstalling the mongodb client \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[32mLoading the Schema \e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>>/tmp/roboshop.log