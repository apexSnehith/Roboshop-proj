source common.sh
component=cart

echo -e "${color}setting up the Nodejs repos ${nocolor}"
#this downloading a file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
echo -e "${color}installing the nodejs${nocolor}"
#intalling
yum install nodejs -y &>>${log_file}
echo -e "${color}adding user for the service${nocolor}"
useradd roboshop &>>${log_file}
echo -e "${color}create application dir${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}
echo -e "${color}downloading the app code to the app dir"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
echo -e "${color}Unziping${nocolor}"
cd ${app_path}
unzip /tmp/${component}.zip &>>${log_file}
echo -e "${color}Downloading the dependencies${nocolor}"
npm install &>>${log_file}
echo -e "${color}setup systemd service${nocolor}"
cp /home/centos/Roboshop-proj/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
echo -e "${color}Restart services\${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}
