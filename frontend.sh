echo -e "\e[32m Installing nginx \e[0m" &>> /tmp/roboshop.log
yum install nginx -y &> /tmp/roboshop.log

echo -e "\e[32m Removing default nginx content on the web\e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/roboshop.log

echo -e "\e[32m Downloading the frontend content.\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> /tmp/roboshop.log

echo -e "\e[32m Extracting the fronted content.\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

#create nginx reverse proxy configuration file / we need to copy config file.
cp /home/centos/Roboshop-proj/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> /tmp/roboshop.log
echo -e "\e[32m Starting&enabling nginx server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log
