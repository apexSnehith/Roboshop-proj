echo -e "\e[32msetting up the Nodejs repos \e[0m"
#this downloading a file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[32minstalling the nodejs\e[0m"
#intalling
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[32madding user for the service\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[32mcreate application dir\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[32mdownloading the app code to the app dir"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
echo -e "\e[32mUnziping\e[0m"
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log
echo -e "\e[32mDownloading the dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[32msetup systemd service\e[0m"
cp /home/centos/Roboshop-proj/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
echo -e "\e[32mRestart services\\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log
