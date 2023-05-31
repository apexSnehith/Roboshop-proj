component=catalogue
color="\e[33m"
nocolor="\e[0m"
echo -e "${color}setting up the Nodejs repos ${nocolor}"
#this downloading a file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "${color}installing the nodejs${nocolor}"
#intalling
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "${color}adding user for the service${nocolor}"
useradd roboshop &>>/tmp/roboshop.log
echo -e "${color}create application dir${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "${color}downloading the app code to the app dir"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
echo -e "${color}Unziping${nocolor}"
cd /app
unzip /tmp/$component.zip &>>/tmp/roboshop.log
echo -e "${color}Downloading the dependencies${nocolor}"
npm install &>>/tmp/roboshop.log
echo -e "${color}setup systemd service${nocolor}"
cp /home/centos/Roboshop-proj/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log
echo -e "${color}Restart services\${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log
echo -e "${color}Install Mongodb client${nocolor}"
cp /home/centos/Roboshop-proj/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "${color}load schema${nocolor}"
mongo --host mongodb-dev.snehithdops.online </app/schema/$component.js &>>/tmp/roboshop.log
systemctl restart $component >>/tmp/roboshop.log