echo -e "\e[32mInstalling Maven\e[0m"
echo -e "\e[32mInstalling redis\e[0m"
yum install maven -yum &>>/tmp/roboshop.log
echo -e "\e[32mAdding user for the service\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[32mMaking a directory\e[0m"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[32mDownloading the application code\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[32mExtracting\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
echo -e "\e[32mDownloading the dependencies & Building the application\e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log
echo -e "\e[32mSetting up the Shipping service in the SystemD\e[0m"
cp /home/centos/Roboshop-proj/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log
echo -e "\e[32mInstalling&Loading the Schema\e[0m"
yum install mysql -y &>>/tmp/roboshop.log
mysql -h mysql-dev.snehithdops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log
echo -e "\e[32mEnabling&restarting the service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log

