echo -e "\e[32mInstalling python\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log
echo -e "\e[32mAdding the user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

rm -rf /app &>>/tmp/roboshop.log
echo -e "\e[32mmaking a directory for the user\e[0m"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[32mDownloading the Application code\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[32mExtracting\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log
echo -e "\e[32mDownloading the dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
echo -e "\e[32mSetting up the payment service\e[0m"
cp /home/centos/Roboshop-proj/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log
echo -e "\e[32mEnabling&Restarting the service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log