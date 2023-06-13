color="\e[33m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presentup(){
  echo -e "${color}adding user for the service${nocolor}"
  id roboshop &>>${log_file}
  if [ $? -eq 1]; then
    useradd roboshop &>>${log_file}
  fi
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
  echo -e "${color}create application dir${nocolor}"
  rm -rf ${app_path} &>>${log_file}
  mkdir ${app_path} &>>${log_file}

  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
  echo -e "${color}downloading the app code to the app dir"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_file}

  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
  echo -e "${color}Unziping${nocolor}"
  cd ${app_path}
  unzip /tmp/$component.zip &>>${log_file}

  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
}

systemd_setup(){

  echo -e "${color}setup systemd service${nocolor}"
  cp /home/centos/Roboshop-proj/$component.service /etc/systemd/system/$component.service &>>${log_file}

  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
  echo -e "${color}Enabling&restarting the service${nocolor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable $component &>>${log_file}
  systemctl restart $component &>>${log_file}

  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
}

nodejs(){
  echo -e "${color}setting up the Nodejs repos ${nocolor}"
  #this downloading a file
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
  echo -e "${color}installing the nodejs${nocolor}"
  yum install nodejs -y &>>${log_file}

  app_presentup

  echo -e "${color}Downloading the dependencies${nocolor}"
  npm install &>>${log_file}

  systemd_setup
}

mongo_schema_setup(){
  echo -e "${color}Install Mongodb client${nocolor}"
  cp /home/centos/Roboshop-proj/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
  yum install mongodb-org-shell -y &>>${log_file}
  echo -e "${color}load schema${nocolor}"
  mongo --host mongodb-dev.snehithdops.online <${app_path}/schema/$component.js &>>${log_file}
  systemctl restart $component >>${log_file}
}

mysql_schema_setup(){
  echo -e "${color}Installing&Loading the Schema${nocolor}"
  yum install mysql -y >>${log_file}
  mysql -h mysql-dev.snehithdops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql >>${log_file}

}

maven(){
  echo -e "${color}Installing Maven${nocolor}"
  yum install maven -y >>${log_file}

  app_presentup

  echo -e "${color}Downloading the dependencies & Building the application${nocolor}"
  cd /app
  mvn clean package >>${log_file}
  mv target/${component}-1.0.jar ${component}.jar >>${log_file}

  mysql_schema_setup
  systemd_setup
}

python(){
  echo -e "${color}Installing python${nocolor}"
  yum install python36 gcc python3-devel -y >>${log_file}
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi

  app_presentup

  echo -e "${color}Installing Application Dependencies${nocolor}"
  cd /app
  pip3.6 install -r requirements.txt >>${log_file}


  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi

  systemd_setup

}
