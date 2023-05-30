echo -e "\e[32m Copy Mongodb Repo file \e[0m"
cp roboshop.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[32m Installing Mongodb \e[0m"
yum install roboshop-org -y &>>/tmp/roboshop.log

#Modify the Config file to set the "localhost(127.0.0.1) to localhost(0.0.0.0) in the /etc/roboshop.conf
echo -e "\e[32m Configuring the Mongodb listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[32m Restaring the Mongodb service \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log