echo -e "\e[32mConfiguring the YUM repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
#echo -e "\e[32mExtracting\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log
echo -e "\e[32mInstalling the RabbitMQe[0m"
yum install rabbitmq-server -y &>>/tmp/roboshop.log
echo -e "\e[32mEnabling&Starting the service\e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl start rabbitmq-server &>>/tmp/roboshop.log
echo -e "\e[32mCreating user for the application and setting permission\e[0m"
rabbitmqctl add_user roboshop $1 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log