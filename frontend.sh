echo -e "\e[32m Installing nginx \e[0m" &>> /log/roboshop.log
yum install nginx -y &> /log/roboshop.log

echo -e "\e[32m Removing default nginx content on the web\e[0m"
rm -rf /usr/share/nginx/html/* &> /log/roboshop.log

echo -e "\e[32m Downloading the frontend content.\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &> /log/roboshop.log

echo -e "\e[32 Extracting the fronted content.\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &> /log/roboshop.log

#create nginx reverse proxy configuration file / we need to copy config file.
echo -e "\e[32m Starting&enabling nginx server\e[0m"
systemctl enable nginx &>> /log/roboshop.log
systemctl restart nginx &>> /log/roboshop.log
