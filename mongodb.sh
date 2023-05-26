echo -e "\e[32m Copy Mongodb Repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb.log

echo -e "\e[32m Installing Mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/mongodb.log

#Modify the Config file to set the "localhost(127.0.0.1) to localhost(0.0.0.0) in the /etc/mongodb.conf

echo -e "\e[32m Restaring the Mongodb service \e[0m"
systemctl enable mongod &>>/tmp/mongodb.log
systemctl restart mongod &>>/tmp/mongodb.log