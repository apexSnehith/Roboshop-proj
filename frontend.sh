#installing nginx
yum install nginx -y
#start&enable nginx
systemctl enable nginx
systemctl start nginx
#remove default nginx content on the web
cd /usr/share/nginx/html/ ; pwd ; ls -ls
cd
rm -rf /usr/share/nginx/html/*
#download the frontend content.
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
#extract the fronted content
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#create nginx reverse proxy configuration file

#Add the following content
 #/etc/nginx/default.d/roboshop.conf
 #
 #proxy_http_version 1.1;
 #location /images/ {
 #  expires 5s;
 #  root   /usr/share/nginx/html;
 #  try_files $uri /images/placeholder.jpg;
 #}
 #location /api/catalogue/ { proxy_pass http://localhost:8080/; }
 #location /api/user/ { proxy_pass http://localhost:8080/; }
 #location /api/cart/ { proxy_pass http://localhost:8080/; }
 #location /api/shipping/ { proxy_pass http://localhost:8080/; }
 #location /api/payment/ { proxy_pass http://localhost:8080/; }
 #
 #location /health {
 #  stub_status on;
 #  access_log off;
 #}

 systemctl restart nginx