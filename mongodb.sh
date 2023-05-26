echo -e "\e[32m Copy Mongodb Repo file \e[0m" &>> /tmp/mongodb.log
cp mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m Installing Mongodb \e[0m" &>> /tmp/mongodb.log
yum install mongodb-org -y
#Modify the Config file to set the "localhost(127.0.0.1) to localhost(0.0.0.0) in the /etc/mongodb.conf
echo -e "\e[32m Restaring the Mongodb service \e[0m" &>> /tmp/momgodb.log