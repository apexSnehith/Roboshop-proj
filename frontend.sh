echo -e "\e[32minstalling nginx \e[0m"
yum install nginx -y
echo -e "\e[32mremove default nginx content on the web\e[0m"
cd /usr/share/nginx/html/ ; pwd ; ls -ls
cd
rm -rf /usr/share/nginx/html/*
echo -e "\e[32mdownload the frontend content.\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[32extract the fronted content.\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
#create nginx reverse proxy configuration file / we need to copy config file.
echo -e "\e[32mstarting&enabling nginx\e[0m"
systemctl enable nginx
systemctl restart nginx
