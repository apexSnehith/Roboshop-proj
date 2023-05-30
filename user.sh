echo -e "\e[32mSetting up the NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[32mInstalling NodeJS\e[0m"
yum install nodejs -y
echo -e "\e[32mAdding the user for the service\e[0m"
useradd roboshop
echo -e "\e[32mmaking a directory \e[0m"
mkdir /app
echo -e "\e[32mDowloding the application code \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[32mExtracting the file\e[0m"
unzip /tmp/user.zip
echo -e "\e[32mInstalling the dependencies \e[0m"
npm install
echo -e "\e[32mSetting up the service \e[0m"
cp /home/centos/Roboshop-proj/user.service /etc/systemd/system/user.service
echo -e "\e[32mEnabling&restarting the service \e[0m"
systemctl daemon-reload
systemctl enabling user
systemctl restart user
echo -e "\e[32mSetting up the schema to install the mongodb client \e[0m"
cp /home/centos/Roboshop-proj/mongo.repo /etc/systemd/system/mongo.repo
echo -e "\e[32mInstalling the mongodb client \e[0m"
yum install mongodb-org-shell -y
echo -e "\e[32mLoading the Schema \e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js