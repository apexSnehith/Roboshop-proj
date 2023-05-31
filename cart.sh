source common.sh
component=cart
echo -e "${color}setting up the Nodejs repos ${nocolor}"
#this downloading a file
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_path}
echo -e "${color}installing the nodejs${nocolor}"
#intalling
yum install nodejs -y &>>${log_path}
echo -e "${color}adding user for the service${nocolor}"
useradd roboshop &>>${log_path}
echo -e "${color}create application dir${nocolor}"
rm -rf ${app_path} &>>${log_path}
mkdir ${app_path} &>>${log_path}
echo -e "${color}downloading the app code to the app dir"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_path}
echo -e "${color}Unziping${nocolor}"
cd ${app_path}
unzip /tmp/${component}.zip &>>${log_path}
echo -e "${color}Downloading the dependencies${nocolor}"
npm install &>>${log_path}
echo -e "${color}setup systemd service${nocolor}"
cp /home/centos/Roboshop-proj/${component}.service /etc/systemd/system/${component}.service &>>${log_path}
echo -e "${color}Restart services\${nocolor}"
systemctl daemon-reload &>>${log_path}
systemctl enable ${component} &>>${log_path}
systemctl restart ${component} &>>${log_path}
